import 'package:flutter/material.dart';
import 'package:prestapp/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/Articulo_controller.dart';
import '../../models/Articulo_model.dart';
import '../../widgets/imagen_articulo.dart';

/// Pantalla para editar un artículo existente. Precarga los datos y permite
/// eliminarlo.
class EditarScreen extends StatefulWidget {
  final Articulo articulo;

  const EditarScreen({super.key, required this.articulo});

  @override
  State<EditarScreen> createState() => _EditarScreenState();
}

class _EditarScreenState extends State<EditarScreen> {
  final ArticuloController _controller = ArticuloController();
  late TextEditingController _nombreCtrl;
  late TextEditingController _descripcionCtrl;
  String? _imagenActual;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();
    _nombreCtrl = TextEditingController(text: widget.articulo.nombre);
    _descripcionCtrl = TextEditingController(text: widget.articulo.descripcion);
    _imagenActual = widget.articulo.imagen;
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _descripcionCtrl.dispose();
    super.dispose();
  }

  Future<void> _cambiarFoto() async {
    await _controller.SeleccionarImagen();
    if (_controller.imageTemp != null) {
      setState(() => _imagenActual = _controller.imageTemp);
    }
  }

  Future<void> _guardar() async {
    if (_nombreCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.nombreObligatorio)),
      );
      return;
    }

    setState(() => _guardando = true);
    final actualizado = Articulo(
      id: widget.articulo.id,
      nombre: _nombreCtrl.text.trim(),
      descripcion: _descripcionCtrl.text.trim(),
      imagen: _imagenActual,
    );
    await _controller.editarArticulo(actualizado);
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  Future<void> _confirmarEliminar() async {
    final t = AppLocalizations.of(context)!;
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.eliminarObjetoTitulo),
        content: Text(t.accionNoSePuedeDeshacer),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.cancelar),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.eliminar, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmar == true && widget.articulo.id != null) {
      await _controller.EliminarArticulo(widget.articulo.id!);
      if (!mounted) return;
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textSecondary = Theme.of(context).textTheme.bodySmall?.color;
    final bgcolor = Theme.of(context).cardColor;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          t.editarObjetoTitulo,
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Foto actual
              GestureDetector(
                onTap: _cambiarFoto,
                child: ImagenArticulo(
                  rutaImagen: _imagenActual,
                  width: 120,
                  height: 120,
                  borderRadius: 16,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _cambiarFoto,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_outlined,
                        size: 14, color: textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      t.cambiarFoto,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Campo nombre
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.nombreObjetoLabel,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: textSecondary,
                      ),
                    ),
                    TextField(
                      controller: _nombreCtrl,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF2D2D2D), width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF2D2D2D), width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Campo descripción
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.descripcionLabel,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: bgcolor,
                        borderRadius: BorderRadius.circular(12),

                      ),
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        controller: _descripcionCtrl,
                        maxLines: 4,
                        style: GoogleFonts.inter(fontSize: 15),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Botón guardar
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _guardando ? null : _guardar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      t.guardarCambios,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),

              // Botón eliminar
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: TextButton(
                  onPressed: _confirmarEliminar,
                  child: Text(
                    t.eliminarObjetoBoton,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFC98B7A),
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
