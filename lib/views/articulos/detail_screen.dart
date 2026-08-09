import 'package:flutter/material.dart';
import 'package:prestapp/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prestapp/models/Prestamo_model.dart';
import '../../database/database_helper.dart';
import '../../models/Articulo_model.dart';
import '../../widgets/imagen_articulo.dart';
import '../prestamos/crearPrestamo_screen.dart';
import 'edit_screen.dart';

/// Pantalla de detalle de un artículo: foto grande, descripción, estado
/// y botón principal (Prestar / Marcar como devuelto).
class DetalleScreen extends StatefulWidget {
  final Articulo articulo;

  const DetalleScreen({super.key, required this.articulo});

  @override
  State<DetalleScreen> createState() => _DetalleScreenState();
}

class _DetalleScreenState extends State<DetalleScreen> {
  final DatabaseHelper _db = DatabaseHelper();
  late Articulo _articulo;
  Prestamo? _prestamo;

  @override
  void initState() {
    super.initState();
    _articulo = widget.articulo;
    _cargarPrestamo();
  }

  Future<void> _cargarPrestamo() async {
    if (_articulo.estaPrestado && _articulo.id != null) {
      final p = await _db.getPrestamoActivo(_articulo.id!);
      if (mounted) {
        setState(() {
          _prestamo = p;
        });
      }
    }
  }

  String _formatearFecha(String? iso) {
    if (iso == null) return '';
    try {
      return DateFormat("dd 'de' MMMM", 'es_ES').format(DateTime.parse(iso));
    } catch (_) {
      return iso;
    }
  }

  Future<void> _confirmarDevolucion() async {
    if (_articulo.id == null) return;
    final prestamoActivo = await _db.getPrestamoActivo(_articulo.id!);
    if (prestamoActivo?.id == null) return;
    final t = AppLocalizations.of(context)!;

    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.detalleConfirmarDevolucionTitulo),
        content: Text(
          t.detalleConfirmarDevolucionTexto(_articulo.nombre),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.cancelar),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.confirmar),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      await _db.DevolverPrestamo(prestamoActivo!.id!);
      // Recarga el artículo actualizado desde la base de datos.
      final todos = await _db.getAllArticulos();
      final actualizado = todos.firstWhere((a) => a.id == _articulo.id);
      if (!mounted) return;
      setState(() {
        _articulo = actualizado;
        _prestamo = null;
      });
    }
  }

  Future<void> _irAPrestar() async {
    final ok = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormularioPrestamoScreen(articulo: _articulo),
      ),
    );
    if (ok == true) {
      final todos = await _db.getAllArticulos();
      final actualizado = todos.firstWhere((a) => a.id == _articulo.id);
      if (!mounted) return;
      setState(() {
        _articulo = actualizado;
      });
      _cargarPrestamo();
    }
  }

  Future<void> _irAEditar() async {
    final t = AppLocalizations.of(context);
    if(_articulo.estaPrestado != true) {
      final ok = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => EditarScreen(articulo: _articulo)),
      );
      if (ok == true && mounted) {
        Navigator.pop(context, true); // avisa a HomeScreen que recargue
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(t!.noSePuedeEditarPrestado),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2)
      ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final prestado = _articulo.estaPrestado;
    final textSecondary = Theme.of(context).textTheme.bodySmall?.color;
    final prestadoDesdeTexto = t.prestadoDesde(
      _articulo.nombrePersona ?? '',
      _formatearFecha(_articulo.fechaPrestamo),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 20),
            onPressed: _irAEditar,
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen principal + chip flotante de estado
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 4 / 3,
                      child: ImagenArticulo(
                        rutaImagen: _articulo.imagen,
                        width: double.infinity,
                        height: double.infinity,
                        borderRadius: 16,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          prestado ? t.prestado : t.disponible,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF2D2D2D),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _articulo.nombre,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      t.descripcionLabel,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _articulo.descripcion,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Chip de estado
                    if (!prestado)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF7A7A7A)),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          t.disponible,
                          style: const TextStyle(color: Color(0xFF7A7A7A)),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDE8E8),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          prestadoDesdeTexto,
                          style: const TextStyle(color: Color(0xFF8B3A3A)),
                        ),
                      ),

                    if (prestado) ...[
                      const SizedBox(height: 16),
                      Text(
                        t.notaPrestado,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          color: textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.note_add_outlined,
                              size: 16, color: textSecondary),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _prestamo?.nota ?? '',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: prestado ? _confirmarDevolucion : _irAPrestar,
              icon: Icon(
                prestado
                    ? Icons.assignment_return_outlined
                    : Icons.handshake_outlined,
              ),
              label: Text(
                prestado ? t.marcarComoDevuelto : t.prestarEsteObjeto,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Color.lerp(Theme.of(context).colorScheme.primary, Colors.white, 0.7),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
