import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prestapp/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/Articulo_controller.dart';

/// Pantalla para crear un nuevo artículo (foto + nombre + descripción).
class CrearScreen extends StatefulWidget {
  const CrearScreen({super.key});

  @override
  State<CrearScreen> createState() => _CrearScreenState();
}

class _CrearScreenState extends State<CrearScreen> {
  final ArticuloController _controller = ArticuloController();
  final _nombreCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();
  bool _guardando = false;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _descripcionCtrl.dispose();
    super.dispose();
  }

  Future<void> _seleccionarImagen() async {
    await _controller.SeleccionarImagen();
    setState(() {});
  }

  Future<void> _guardar() async {
    if (_nombreCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.nombreObligatorio)),
      );
      return;
    }

    setState(() => _guardando = true);
    await _controller.aggArticulo(
      _nombreCtrl.text.trim(),
      _descripcionCtrl.text.trim(),
    );
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textSecondary = Theme.of(context).textTheme.bodySmall?.color;
    final bgColor = Theme.of(context).colorScheme.surface;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          t.nuevoObjetoTitulo,
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Área de foto
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: _seleccionarImagen,
                  child: Container(
                    width: 200,
                    height: 180,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: bgColor,
                      border: Border.all(
                        color: const Color(0xFFD0D0D0),
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: _controller.imageTemp != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              File(_controller.imageTemp!),
                              width: 200,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.camera_alt_outlined,
                                size: 40,
                                color: Color(0xFFB0B0B0),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                t.agregarFoto,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color(0xFFB0B0B0),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),

              // Campo nombre
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
                child: TextField(
                  controller: _nombreCtrl,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: textSecondary,
                  ),
                  decoration: InputDecoration(
                    hintText: t.nombreObjetoHint,
                    hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFFB0B0B0),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF2D2D2D), width: 2),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF2D2D2D), width: 2),
                    ),
                  ),
                ),
              ),

              // Campo descripción
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20,),
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12),

                  ),
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: _descripcionCtrl,
                    maxLines: 4,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: const Color(0xFF2D2D2D),

                    ),
                    decoration: InputDecoration(
                      hintText: t.descripcionOpcionalHint,
                      hintStyle: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFFB0B0B0),

                      ),
                      border: InputBorder.none,
                    ),

                  ),
                ),
              ),

              // Botón guardar
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _guardando ? null : _guardar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
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
                            t.guardarObjeto,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
