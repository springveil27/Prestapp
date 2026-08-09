// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get prestApp => 'PrestApp';

  @override
  String get editar => 'Editar';

  @override
  String get eliminar => 'Eliminar';

  @override
  String get cancelar => 'Cancelar';

  @override
  String get confirmar => 'Confirmar';

  @override
  String get disponible => 'Disponible';

  @override
  String get prestado => 'Prestado';

  @override
  String get descripcionLabel => 'DESCRIPCIÓN';

  @override
  String get ajustesTitulo => 'Ajustes';

  @override
  String get idioma => 'Idioma';

  @override
  String get espanol => 'Español';

  @override
  String get ingles => 'Inglés';

  @override
  String get colorApp => 'Color de la App';

  @override
  String get colorAppSubtitulo => 'Elige tu tono de papel preferido.';

  @override
  String get modo => 'Modo';

  @override
  String get claro => 'Claro';

  @override
  String get oscuro => 'Oscuro';

  @override
  String objetoDisponible(int count) {
    return 'Objeto disponible ($count)';
  }

  @override
  String get listaVacia => 'Aún no tienes artículos.\nToca + para agregar uno.';

  @override
  String get detalleConfirmarDevolucionTitulo => '¿Marcar como devuelto?';

  @override
  String detalleConfirmarDevolucionTexto(String nombre) {
    return '$nombre volverá a estar disponible.';
  }

  @override
  String prestadoDesde(String nombre, String fecha) {
    return 'Prestado a $nombre desde el $fecha';
  }

  @override
  String get marcarComoDevuelto => 'MARCAR COMO DEVUELTO';

  @override
  String get prestarEsteObjeto => 'PRESTAR ESTE OBJETO';

  @override
  String get nombreObligatorio => 'El nombre del objeto es obligatorio';

  @override
  String get nuevoObjetoTitulo => 'Nuevo Objeto';

  @override
  String get agregarFoto => 'Agregar foto';

  @override
  String get guardarObjeto => 'Guardar Objeto';

  @override
  String get nombreObjetoHint => 'Nombre del objeto';

  @override
  String get descripcionOpcionalHint => 'Descripción (opcional)';

  @override
  String get eliminarObjetoTitulo => '¿Eliminar objeto?';

  @override
  String get accionNoSePuedeDeshacer => 'Esta acción no se puede deshacer';

  @override
  String get editarObjetoTitulo => 'Editar Objeto';

  @override
  String get cambiarFoto => 'Cambiar foto';

  @override
  String get nombreObjetoLabel => 'NOMBRE DEL OBJETO';

  @override
  String get guardarCambios => 'GUARDAR CAMBIOS';

  @override
  String get eliminarObjetoBoton => 'Eliminar Objeto';

  @override
  String get nombrePersonaObligatorio => 'Escribe el nombre de la persona';

  @override
  String get propio => 'Propio';

  @override
  String get prestarTitulo => 'Prestar';

  @override
  String get aQuienSeLoPrestas => '¿A QUIÉN SE LO PRESTAS?';

  @override
  String get escribeUnNombreHint => 'Escribe un nombre...';

  @override
  String get notasOpcional => 'NOTAS (OPCIONAL)';

  @override
  String get notaHint => 'Algún recordatorio o estado del objeto...';

  @override
  String get confirmarPrestamo => 'Confirmar Préstamo';

  @override
  String get historialTitulo => 'Historial';

  @override
  String get sinPrestamos => 'Aún no has registrado préstamos.';

  @override
  String prestadoAPersona(String nombre) {
    return 'Prestado a $nombre';
  }

  @override
  String get devuelto => 'DEVUELTO';

  @override
  String get noSePuedeEliminarPrestado =>
      'No se puede eliminar un artículo que está prestado.';

  @override
  String get noSePuedeEditarPrestado =>
      'No se puede editar un articulo que esta prestado';

  @override
  String get notaPrestado => 'Nota de Prestamo:';
}
