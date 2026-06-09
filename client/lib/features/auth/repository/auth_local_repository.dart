import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(Ref ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // need to remember
  // late is used with _preference means we first have to init
  // to use getToken or setToken

  void setToken(String? token) {
    if (token != null) {
      _sharedPreferences.setString("x-auth-token", token);
    }
  }

  String? getToken() {
    String? token = _sharedPreferences.getString("x-auth-token");
    return token;
  }
}
