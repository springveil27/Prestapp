import '../models/Prestamo_model.dart';
import '../database/database_helper.dart';

class PrestamoController {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Prestamo> prestamo = [];

  Future<void> CargarHistorial() async {
    prestamo = await _databaseHelper.getAllPrestamos();
  }

  Future<void> aggPrestamo(
    int idArticulo,
    String nombrePersona,
    String? nota,
  ) async {
    final fechahoy = DateTime.now().toIso8601String();
    final nuevoPrestamo = Prestamo(
      idArticulo: idArticulo,
      nombrePersona: nombrePersona,
      fechaPrestamo: fechahoy,
      fechaDevolucion: null,
      nota: nota,
    );
    await _databaseHelper.crearPrestamo(nuevoPrestamo);
    await CargarHistorial();
  }

  Future<void> DevolverPrestamo(int id) async {
    await _databaseHelper.DevolverPrestamo(id);
    await CargarHistorial();
  }
}
