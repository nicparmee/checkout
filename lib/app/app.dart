import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';

import '../features/cart/presentation/bloc/cart_cubit.dart';
import '../graphql/local_link.dart';
import 'router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => GraphQLClient(link: LocalLink(), cache: GraphQLCache()),
      // Above the router so the cart outlives page navigation.
      child: BlocProvider(
        create: (_) => CartCubit(),
        child: MaterialApp.router(
          title: 'Checkout',
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          ),
          routerConfig: router,
        ),
      ),
    );
  }
}
