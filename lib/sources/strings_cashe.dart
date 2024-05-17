import "package:shared_preferences/shared_preferences.dart"
    show SharedPreferences;

class StringsCashe {
  static SharedPreferences? _preferences;

  static void saveFromCity(String city) async {
    _preferences = _preferences ?? (await SharedPreferences.getInstance());
    _preferences!.setString("fromCity", city);
  }

  static Future<String> getFromCity() async {
    _preferences = _preferences ?? await SharedPreferences.getInstance();
    return _preferences?.getString("fromCity") ?? "";
  }
}
