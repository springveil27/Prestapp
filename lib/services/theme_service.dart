import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Construye los [ThemeData] de la app a partir del modo (claro/oscuro)
// y el índice de color de acento elegido en Ajustes.
class ThemeService {
  ThemeService._();



  static const List<Color> presets = [
    Color(0xFF6B7F5E), // 0. verde musgo
    Color(0xFF9CAE8F), // 1. verde salvia
    Color(0xFFD4957A), // 2. salmón
    Color(0xFF7A8B74), // 3. verde gris
    Color(0xFFE08D6E), // 4. coral
    Color(0xFFB07A8A), // 5. malva
    Color(0xFF63E3D0), // 6. azul celeste
    Color.fromARGB(255, 126, 77, 181), // 7. violeta
  ];

  static Color accentColor(int index) {
    if (index < 0 || index >= presets.length) return presets[0];
    return presets[index];
  }

  // Colores base (modo claro)
  static const Color _bgScaffoldLight = Color(0xFFF5F3EE);
  static const Color _bgCardLight = Color(0xFFFFFFFF);
  static const Color _textPrimaryLight = Color(0xFF2D2D2D);
  static const Color _textSecondaryLight = Color(0xFF7A7A7A);
  static const Color _dividerLight = Color(0xFFE0DDD6);

  // Colores base (modo oscuro)
  static const Color _bgScaffoldDark = Color(0xFF1C1C1E);
  static const Color _bgCardDark = Color(0xFF2C2C2E);
  static const Color _textPrimaryDark = Color(0xFFEAEAEA);
  static const Color _textSecondaryDark = Color(0xFF9A9A9A);

  static ThemeData buildTheme({
    required bool isDarkMode,
    required int accentIndex,
  }) {
    final accent = accentColor(accentIndex);
    final brightness = isDarkMode ? Brightness.dark : Brightness.light;
    final scaffoldColor = isDarkMode ? _bgScaffoldDark : _bgScaffoldLight;
    final cardColor = isDarkMode ? _bgCardDark : _bgCardLight;
    final textPrimary = isDarkMode ? _textPrimaryDark : _textPrimaryLight;
    final textSecondary = isDarkMode ? _textSecondaryDark : _textSecondaryLight;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: brightness,
      primary: accent,
      surface: cardColor,
    );

    final baseTextTheme = GoogleFonts.interTextTheme(
      brightness == Brightness.dark
          ? ThemeData.dark().textTheme
          : ThemeData.light().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: scaffoldColor,
      colorScheme: colorScheme,
      primaryColor: accent,
      cardColor: cardColor,
      dividerColor: isDarkMode ? const Color(0xFF3A3A3C) : _dividerLight,
      textTheme: baseTextTheme.apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF3A3A3C),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: GoogleFonts.inter(color: const Color(0xFFB0B0B0)),
        border: InputBorder.none,
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: accent),
      extensions: <ThemeExtension<dynamic>>[
        PrestAppColors(
          textSecondary: textSecondary,
          badgeDisponibleFondo:
              isDarkMode ? const Color(0xFF3A4A32) : const Color(0xFFE8EDE3),
          badgeDisponibleTexto:
              isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF),
          badgePrestadoFondo:
              isDarkMode ? const Color(0xFF4A2E2E) : const Color(0xFFFDE8E8),
          badgePrestadoTexto:
              isDarkMode ? const Color(0xFFE4A6A6) : const Color(0xFF8B3A3A),
          inputFillSuave:
              isDarkMode ? const Color(0xFF2A2A2C) : const Color(0xFFF9F8F6),
        ),
      ],
    );
  }
}

/// Colores propios de PrestApp que no forman parte del [ColorScheme]
class PrestAppColors extends ThemeExtension<PrestAppColors> {
  final Color textSecondary;
  final Color badgeDisponibleFondo;
  final Color badgeDisponibleTexto;
  final Color badgePrestadoFondo;
  final Color badgePrestadoTexto;
  final Color inputFillSuave;

  const PrestAppColors({
    required this.textSecondary,
    required this.badgeDisponibleFondo,
    required this.badgeDisponibleTexto,
    required this.badgePrestadoFondo,
    required this.badgePrestadoTexto,
    required this.inputFillSuave,
  });

  @override
  PrestAppColors copyWith({
    Color? textSecondary,
    Color? badgeDisponibleFondo,
    Color? badgeDisponibleTexto,
    Color? badgePrestadoFondo,
    Color? badgePrestadoTexto,
    Color? inputFillSuave,
  }) {
    return PrestAppColors(
      textSecondary: textSecondary ?? this.textSecondary,
      badgeDisponibleFondo: badgeDisponibleFondo ?? this.badgeDisponibleFondo,
      badgeDisponibleTexto: badgeDisponibleTexto ?? this.badgeDisponibleTexto,
      badgePrestadoFondo: badgePrestadoFondo ?? this.badgePrestadoFondo,
      badgePrestadoTexto: badgePrestadoTexto ?? this.badgePrestadoTexto,
      inputFillSuave: inputFillSuave ?? this.inputFillSuave,
    );
  }

  @override
  PrestAppColors lerp(ThemeExtension<PrestAppColors>? other, double t) {
    if (other is! PrestAppColors) return this;
    return PrestAppColors(
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      badgeDisponibleFondo:
          Color.lerp(badgeDisponibleFondo, other.badgeDisponibleFondo, t)!,
      badgeDisponibleTexto:
          Color.lerp(badgeDisponibleTexto, other.badgeDisponibleTexto, t)!,
      badgePrestadoFondo:
          Color.lerp(badgePrestadoFondo, other.badgePrestadoFondo, t)!,
      badgePrestadoTexto:
          Color.lerp(badgePrestadoTexto, other.badgePrestadoTexto, t)!,
      inputFillSuave: Color.lerp(inputFillSuave, other.inputFillSuave, t)!,
    );
  }
}
