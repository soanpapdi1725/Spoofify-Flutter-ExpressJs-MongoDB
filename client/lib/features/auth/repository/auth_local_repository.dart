import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalRepository {
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // need to remember
  // late is used with _preference means we first have to init
  // to use getToken or setToken

  void setToken(String? token) async {
    await init();
    if (token != null) {
      _preferences.setString("x-auth-token", token);
    }
  }

  Future<String?> getTokem() async {
    await init();
    String token = _preferences.getString("x-auth-token")!;
    return token;
  }
}
