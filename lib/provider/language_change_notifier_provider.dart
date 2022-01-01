import 'package:flutter/cupertino.dart';
import 'package:note_provider/prefs/app_settings_prefs.dart';

class LanguageChangeNotifierProvider extends ChangeNotifier {

  String _languageCode = AppSettingsPreferences().langCode;

  Future<void> changeLanguage({required String languageCode}) async {
    this._languageCode = languageCode;
    await AppSettingsPreferences().saveLanguage(language: languageCode);
    notifyListeners();
  }

  String get languageCode => _languageCode;
}