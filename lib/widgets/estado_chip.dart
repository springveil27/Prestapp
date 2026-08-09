import 'package:flutter/material.dart';
import 'package:prestapp/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/theme_service.dart';

/// Chip que muestra "Disponible" o "Prestado a [nombre]".
class EstadoChip extends StatelessWidget {
  final bool disponible;
  final String? prestadoA;

  const EstadoChip({super.key, required this.disponible, this.prestadoA});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<PrestAppColors>()!;
    final t = AppLocalizations.of(context)!;

    final String texto =
        disponible ? t.disponible : t.prestadoAPersona(prestadoA ?? '');
    final Color fondo =
        disponible ? Theme.of(context).colorScheme.primary : colors.badgePrestadoFondo;
    final Color? textoColor =
        disponible ? Color.lerp(Theme.of(context).colorScheme.primary, Colors.white, 0.8) : colors.badgePrestadoTexto;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texto,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textoColor,
        ),
      ),
    );
  }
}
