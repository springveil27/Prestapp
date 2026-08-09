import 'package:shared_preferences/shared_preferences.dart';

/// Servicio de preferencias del usuario (tema, idioma, color de acento).

class PreferenceService {
  static final PreferenceService _instance = PreferenceService._internal();
  factory PreferenceService() => _instance;
  Pflutter upgrade
  referenceService._internal();

  static const _keyDarkMode = 'isDarkMode';
  static const _keyLanguage = 'language';
  static const _keyAccentIndex = 'accentColorIndex';

  bool _isDarkMode = false;
  String _language = 'es';
  int _accentColorIndex = 0;

  SharedPreferences? _prefs;

  /// Debe llamarse una vez al inicio (main.dart) antes de usar el servicio.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs?.getBool(_keyDarkMode) ?? false;
    _language = _prefs?.getString(_keyLanguage) ?? 'es';
    _accentColorIndex = _prefs?.getInt(_keyAccentIndex) ?? 0;
  }

  Future<bool> getIsDarkMode() async {
    return _isDarkMode;
  }

  Future<void> setIsDarkMode(bool value) async {
    _isDarkMode = value;
    await _prefs?.setBool(_keyDarkMode, value);
  }

  Future<String> getLanguage() async {
    return _language;
  }

  Future<void> setLanguage(String value) async {
    _language = value;
    await _prefs?.setString(_keyLanguage, value);
  }

  /// Índice (0-7) del color de acento elegido en Ajustes.
  Future<int> getAccentColorIndex() async {
    return _accentColorIndex;
  }

  Future<void> setAccentColorIndex(int value) async {
    _accentColorIndex = value;
    await _prefs?.setInt(_keyAccentIndex, value);
  }

  Future<void> savePreferences({
    required bool isDarkMode,
    required String language,
    int? accentColorIndex,
  }) async {
    _isDarkMode = isDarkMode;
    _language = language;
    await _prefs?.setBool(_keyDarkMode, isDarkMode);
    await _prefs?.setString(_keyLanguage, language);
    if (accentColorIndex != null) {
      _accentColorIndex = accentColorIndex;
      await _prefs?.setInt(_keyAccentIndex, accentColorIndex);
    }
  }
}
