import 'package:flutter/material.dart';
import 'package:prestapp/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../services/preference_service.dart';
import '../services/theme_service.dart';

/// Pantalla de configuración: idioma, color de acento y modo claro/oscuro.
class AjustesScreen extends StatefulWidget {
  const AjustesScreen({super.key});

  @override
  State<AjustesScreen> createState() => _AjustesScreenState();
}

class _AjustesScreenState extends State<AjustesScreen> {
  final PreferenceService _prefs = PreferenceService();

  String _idioma = 'es';
  int _accentIndex = 0;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _cargarPreferencias();
  }

  Future<void> _cargarPreferencias() async {
    final idioma = await _prefs.getLanguage();
    final accent = await _prefs.getAccentColorIndex();
    final oscuro = await _prefs.getIsDarkMode();
    if (!mounted) return;
    setState(() {
      _idioma = idioma;
      _accentIndex = accent;
      _isDarkMode = oscuro;
    });
  }

  Future<void> _cambiarIdioma(String idioma) async {
    setState(() => _idioma = idioma);
    await _prefs.setLanguage(idioma);
    prestAppKey.currentState?.actualizarIdioma(idioma);
  }

  Future<void> _cambiarAccent(int index) async {
    setState(() => _accentIndex = index);
    await _prefs.setAccentColorIndex(index);
    prestAppKey.currentState?.actualizarTema(accentIndex: index);
  }

  Future<void> _cambiarModo(bool oscuro) async {
    setState(() => _isDarkMode = oscuro);
    await _prefs.setIsDarkMode(oscuro);
    prestAppKey.currentState?.actualizarTema(isDarkMode: oscuro);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textSecondary = Theme.of(context).textTheme.bodySmall?.color;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          t.ajustesTitulo,
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // Idioma
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              child: Text(
                t.idioma,
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            _OpcionIdioma(
              label: t.espanol,
              seleccionado: _idioma == 'es',
              onTap: () => _cambiarIdioma('es'),
            ),
            const Divider(height: 1),
            _OpcionIdioma(
              label: t.ingles,
              seleccionado: _idioma == 'en',
              onTap: () => _cambiarIdioma('en'),
            ),

            // Color de la app
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.colorApp,
                    style: GoogleFonts.inter(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.colorAppSubtitulo,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(ThemeService.presets.length, (i) {
                      final seleccionado = _accentIndex == i;
                      final angle = 0.02 + (i % 4) * 0.02;
                      return Transform.rotate(
                        angle: angle,
                        child: GestureDetector(
                          onTap: () => _cambiarAccent(i),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: i == 0
                                  ? Colors.white
                                  : ThemeService.presets[i],
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: seleccionado
                                    ? const Color(0xFF2D2D2D)
                                    : (i == 0
                                        ? const Color(0xFFD0D0D0)
                                        : Colors.transparent),
                                width: 2,
                              ),
                            ),
                            child: seleccionado
                                ? const Icon(Icons.check,
                                    color: Colors.white, size: 20)
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Modo claro/oscuro
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.modo,
                    style: GoogleFonts.inter(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Builder(
                    builder: (context) {
                      final isDark = Theme.of(context).brightness == Brightness.dark;
                      return Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF3A3A3C)
                              : const Color(0xFFF0EFED),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            _OpcionModo(
                              label: t.claro,
                              seleccionado: !_isDarkMode,
                              onTap: () => _cambiarModo(false),
                            ),
                            _OpcionModo(
                              label: t.oscuro,
                              seleccionado: _isDarkMode,
                              onTap: () => _cambiarModo(true),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _OpcionIdioma extends StatelessWidget {
  final String label;
  final bool seleccionado;
  final VoidCallback onTap;

  const _OpcionIdioma({
    required this.label,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: GoogleFonts.inter(fontSize: 15)),
            if (seleccionado) const Icon(Icons.check, color: Color(0xFF6B7F5E)),
          ],
        ),
      ),
    );
  }
}

class _OpcionModo extends StatelessWidget {
  final String label;
  final bool seleccionado;
  final VoidCallback onTap;

  const _OpcionModo({
    required this.label,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = Theme.of(context).colorScheme.primary;

    final Color fondoSeleccionado = isDark ? Theme.of(context).colorScheme.primary : accent.withOpacity(0.18);
    final Color textoSeleccionado = isDark ? Colors.white : const Color(0xFF2D2D2D);
    final Color textoNoSeleccionado = isDark ? const Color(0xFF9A9A9A) : const Color(0xFF7A7A7A);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          decoration: BoxDecoration(
            color: seleccionado ? fondoSeleccionado : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: seleccionado ? textoSeleccionado : textoNoSeleccionado,
            ),
          ),
        ),
      ),
    );
  }
}
