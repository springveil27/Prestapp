import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/Articulo_model.dart';
import 'estado_chip.dart';
import 'imagen_articulo.dart';

// Item de lista usado en HomeScreen: foto + nombre + chip de estado + menú.
class ObjetoListTile extends StatelessWidget {
  final Articulo articulo;
  final VoidCallback onTap;
  final VoidCallback onMenuTap;

  const ObjetoListTile({
    super.key,
    required this.articulo,
    required this.onTap,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final textSecondary =
        Theme.of(context).textTheme.bodySmall?.color ?? const Color(0xFF7A7A7A);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal:16 , vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ImagenArticulo(
                rutaImagen: articulo.imagen,
                width: 80,
                height: 90,
                borderRadius: 12,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      articulo.nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    EstadoChip(
                      disponible: !articulo.estaPrestado,
                      prestadoA: articulo.nombrePersona,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_vert, size: 20, color: textSecondary),
                onPressed: onMenuTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
