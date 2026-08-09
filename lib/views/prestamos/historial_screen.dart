import 'package:flutter/material.dart';
import 'package:prestapp/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../database/database_helper.dart';
import '../../models/Prestamo_model.dart';
import '../../widgets/prestamo_list_tile.dart';

/// Pantalla de historial de todos los préstamos realizados.
class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  final DatabaseHelper _db = DatabaseHelper();
  List<Prestamo> _prestamos = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarHistorial();
  }

  Future<void> _cargarHistorial() async {
    final historial = await _db.getHistorialPrestamos();
    if (!mounted) return;
    setState(() {
      _prestamos = historial;
      _cargando = false;
    });
  }

  Future<void> _marcarDevuelto(Prestamo prestamo) async {
    if (prestamo.id == null) return;
    await _db.DevolverPrestamo(prestamo.id!);
    await _cargarHistorial();
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
        titleSpacing: 0,
        title: Text(
          t.historialTitulo,
          style: GoogleFonts.playfairDisplay(
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : _prestamos.isEmpty
              ? Center(
                  child: Text(
                    t.sinPrestamos,
                    style: GoogleFonts.inter(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _prestamos.length,
                  itemBuilder: (context, index) {
                    final prestamo = _prestamos[index];
                    return PrestamoListTile(
                      prestamo: prestamo,
                      onMarcarDevuelto: () => _marcarDevuelto(prestamo),
                    );
                  },
                ),
    );
  }
}
