import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Signed-in flag, persisted so it survives a refresh.
class AuthCubit extends Cubit<bool> {
  AuthCubit(this._prefs) : super(_prefs.getBool(_key) ?? false);

  static const _key = 'signedIn';
  final SharedPreferences _prefs;

  void signIn() => _set(true);

  void signOut() => _set(false);

  void _set(bool signedIn) {
    _prefs.setBool(_key, signedIn);
    emit(signedIn);
  }
}
