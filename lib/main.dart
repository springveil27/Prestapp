import 'package:flutter/material.dart';
import 'package:prestapp/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'services/preference_service.dart';
import 'services/theme_service.dart';
import 'views/articulos/home_screen.dart';

/// Key global al widget raíz. AjustesScreen la usa para pedirle a PrestApp
final GlobalKey<PrestAppState> prestAppKey = GlobalKey<PrestAppState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa datos de formato de fecha en español (usados por intl
  // en HistorialScreen y DetalleScreen, ej. "12 de Octubre de 2023").
  await initializeDateFormatting('es_ES', null);

  final prefs = PreferenceService();
  await prefs.init();

  final isDarkMode = await prefs.getIsDarkMode();
  final accentIndex = await prefs.getAccentColorIndex();
  final idioma = await prefs.getLanguage();

  runApp(
    PrestApp(
      key: prestAppKey,
      isDarkModeInicial: isDarkMode,
      accentIndexInicial: accentIndex,
      idiomaInicial: idioma,
    ),
  );
}

/// Widget raíz de la aplicación.
class PrestApp extends StatefulWidget {
  final bool isDarkModeInicial;
  final int accentIndexInicial;
  final String idiomaInicial;

  const PrestApp({
    super.key,
    required this.isDarkModeInicial,
    required this.accentIndexInicial,
    required this.idiomaInicial,
  });

  @override
  State<PrestApp> createState() => PrestAppState();
}

class PrestAppState extends State<PrestApp> {
  late bool _isDarkMode = widget.isDarkModeInicial;
  late int _accentIndex = widget.accentIndexInicial;
  late Locale _locale = Locale(widget.idiomaInicial);


  void actualizarTema({bool? isDarkMode, int? accentIndex}) {
    setState(() {
      if (isDarkMode != null) _isDarkMode = isDarkMode;
      if (accentIndex != null) _accentIndex = accentIndex;
    });
  }


  void actualizarIdioma(String idioma) {
    setState(() => _locale = Locale(idioma));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PrestApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeService.buildTheme(
        isDarkMode: false,
        accentIndex: _accentIndex,
      ),
      darkTheme: ThemeService.buildTheme(
        isDarkMode: true,
        accentIndex: _accentIndex,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
