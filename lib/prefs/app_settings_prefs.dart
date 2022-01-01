import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsPreferences{

  static final AppSettingsPreferences _instance = AppSettingsPreferences._internal();

  late SharedPreferences _sharedPreferences;

  factory AppSettingsPreferences(){
    return _instance;
  }

  AppSettingsPreferences._internal();

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveLanguage({required String language}) async {
    await _sharedPreferences.setString('lang_code', language);
  }

  String get langCode => _sharedPreferences.getString('lang_code') ?? 'en';
}