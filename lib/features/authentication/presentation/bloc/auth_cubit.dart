import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Signed-in user id (null when signed out), persisted so it survives a refresh.
class AuthCubit extends Cubit<String?> {
  AuthCubit(this._prefs) : super(_prefs.getString(_key));

  static const _key = 'userId';
  final SharedPreferences _prefs;

  // ponytail: demo sign-in always yields the same user; use the auth
  // provider's id once there is one.
  void signIn() => _set('user-1');

  void signOut() => _set(null);

  void _set(String? userId) {
    userId == null ? _prefs.remove(_key) : _prefs.setString(_key, userId);
    emit(userId);
  }
}
