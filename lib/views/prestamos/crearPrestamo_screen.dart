import 'package:flutter/material.dart';
import 'package:prestapp/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/Prestamo_controller.dart';
import '../../models/Articulo_model.dart';
import '../../widgets/imagen_articulo.dart';

/// Pantalla para registrar un nuevo préstamo de [articulo].
class FormularioPrestamoScreen extends StatefulWidget {
  final Articulo articulo;

  const FormularioPrestamoScreen({super.key, required this.articulo});

  @override
  State<FormularioPrestamoScreen> createState() =>
      _FormularioPrestamoScreenState();
}

class _FormularioPrestamoScreenState extends State<FormularioPrestamoScreen> {
  final PrestamoController _controller = PrestamoController();
  final _nombreCtrl = TextEditingController();
  final _notaCtrl = TextEditingController();
  bool _guardando = false;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _notaCtrl.dispose();
    super.dispose();
  }

  Future<void> _confirmar() async {
    if (_nombreCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.nombrePersonaObligatorio)),
      );
      return;
    }
    if (widget.articulo.id == null) return;

    setState(() => _guardando = true);
    await _controller.aggPrestamo(
      widget.articulo.id!,
      _nombreCtrl.text.trim(),
      _notaCtrl.text.trim().isEmpty ? null : _notaCtrl.text.trim(),
    );
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final bgColor = Theme.of(context).colorScheme.surface;
    final textSecondary = Theme.of(context).textTheme.bodySmall?.color;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const SizedBox.shrink(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'PrestApp',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header del objeto
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImagenArticulo(
                      rutaImagen: widget.articulo.imagen,
                      width: 60,
                      height: 60,
                      borderRadius: 12,
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8EDE3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            t.propio,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: const Color(0xFF4A5D3F),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          t.prestarTitulo,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          widget.articulo.nombre,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // A quién se lo prestas
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.aQuienSeLoPrestas,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _nombreCtrl,
                            style: GoogleFonts.inter(
                                fontSize: 17, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              hintText: t.escribeUnNombreHint,
                              hintStyle: GoogleFonts.inter(
                                fontSize: 15,
                                color: const Color(0xFFB0B0B0),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFE0DDD6)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF2D2D2D)),
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.person_outline,
                            size: 20, color: textSecondary),
                      ],
                    ),
                  ],
                ),
              ),

              // Notas
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.notasOpcional,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: _notaCtrl,
                        maxLines: 4,
                        style: GoogleFonts.inter(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: t.notaHint,
                          hintStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFFB0B0B0),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Botón confirmar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: SizedBox(
                    width: 220,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _guardando ? null : _confirmar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(40),
                            right: Radius.circular(40),
                          ),
                        ),
                      ),
                      child: _guardando
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              t.confirmarPrestamo,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
