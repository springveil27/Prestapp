import 'package:flutter/material.dart';
import 'package:prestapp/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/Prestamo_model.dart';
import '../services/theme_service.dart';
import 'imagen_articulo.dart';

/// Item de lista usado en HistorialScreen.
class PrestamoListTile extends StatelessWidget {
  final Prestamo prestamo;
  final VoidCallback onMarcarDevuelto;

  const PrestamoListTile({
    super.key,
    required this.prestamo,
    required this.onMarcarDevuelto,
  });

  String _formatearFecha(String isoDate) {
    try {
      final fecha = DateTime.parse(isoDate);
      return DateFormat("dd 'de' MMMM 'de' yyyy", 'es_ES').format(fecha);
    } catch (_) {
      return isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<PrestAppColors>()!;
    final t = AppLocalizations.of(context)!;
    final devuelto = prestamo.estaDevuelto;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ImagenArticulo(
              rutaImagen: prestamo.imagenArticulo,
              width: 70,
              height: 70,
              borderRadius: 12,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prestamo.nombreArticulo ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    t.prestadoAPersona(prestamo.nombrePersona),
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatearFecha(prestamo.fechaPrestamo),
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (devuelto)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      t.devuelto,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color.lerp(Theme.of(context).colorScheme.primary, Colors.white, 0.5),
                      ),
                    ),
                  )
                else
                  TextButton(
                    onPressed: onMarcarDevuelto,
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Color.lerp(Theme.of(context).colorScheme.primary, Colors.white, 0.99),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      t.marcarComoDevuelto,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
