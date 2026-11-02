import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/order.dart';
import '../../domain/repositories/checkout_repository.dart';

sealed class OrderEvent {}

class OrderRequested extends OrderEvent {}

class PayPressed extends OrderEvent {
  PayPressed(this.cardToken);
  final String cardToken;
}

class _Ticked extends OrderEvent {}

sealed class OrderState {}

class OrderLoading extends OrderState {}

class OrderNotFound extends OrderState {}

class OrderError extends OrderState {
  OrderError(this.message);
  final String message;
}

class OrderLoaded extends OrderState {
  OrderLoaded(this.order, {required this.remaining, this.paying = false});
  final Order order;

  /// True while this page's own pay request is in flight.
  final bool paying;

  /// Time left to pay; zero once the order is settled or expired.
  final Duration remaining;
}

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(this._repository, this._orderId) : super(OrderLoading()) {
    on<OrderRequested>(
      (_, emit) => _run(emit, () => _repository.getOrder(_orderId)),
      transformer: droppable(),
    );
    // Ignores taps while a payment is in flight, so it is never sent twice.
    on<PayPressed>(_onPay, transformer: droppable());
    on<_Ticked>(_onTick);
  }

  final CheckoutRepository _repository;
  final String _orderId;
  Timer? _ticker;

  Future<void> _onPay(PayPressed event, Emitter<OrderState> emit) async {
    if (state case OrderLoaded(:final order, :final remaining)
        when order.payable) {
      emit(OrderLoaded(order, remaining: remaining, paying: true));
      await _run(emit, () => _repository.payOrder(_orderId, event.cardToken));
    }
  }

  void _onTick(_Ticked event, Emitter<OrderState> emit) {
    if (state case OrderLoaded(:final order, :final paying)) {
      // Submitted earlier (e.g. before a refresh): poll until it settles.
      if (order.status == OrderStatus.processing) {
        return add(OrderRequested());
      }
      final remaining = _remaining(order);
      if (remaining > Duration.zero) {
        return emit(OrderLoaded(order, remaining: remaining, paying: paying));
      }
      _ticker?.cancel();
      // The backend flips it to EXPIRED; an in-flight payment reports back itself.
      if (!paying) add(OrderRequested());
    }
  }

  Future<void> _run(
    Emitter<OrderState> emit,
    Future<Order?> Function() request,
  ) async {
    try {
      final order = await request();
      if (order == null) return emit(OrderNotFound());
      emit(OrderLoaded(order, remaining: _remaining(order)));
      _ticker?.cancel();
      if (order.payable || order.status == OrderStatus.processing) {
        _ticker = Timer.periodic(
          const Duration(seconds: 1),
          (_) => add(_Ticked()),
        );
      }
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Duration _remaining(Order order) {
    if (!order.payable) return Duration.zero;
    final left = order.expiresAt.difference(DateTime.now());
    return left.isNegative ? Duration.zero : left;
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
