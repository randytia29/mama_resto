import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKey {
  static const String _accessToken = 'ACCESS_TOKEN';
}

class SharedPref {
  final SharedPreferences sharedPreferences;

  SharedPref({required this.sharedPreferences});

  Future<bool> setAccessToken(String accessToken) async {
    bool accessTokenSaved = await sharedPreferences.setString(
        SharedPrefKey._accessToken, accessToken);

    return accessTokenSaved;
  }

  String? getAccessToken() {
    String? accessToken =
        sharedPreferences.getString(SharedPrefKey._accessToken);

    return accessToken;
  }

  Future<bool> clearAccessToken() async {
    bool accessTokenRemoved =
        await sharedPreferences.remove(SharedPrefKey._accessToken);

    return accessTokenRemoved;
  }
}
