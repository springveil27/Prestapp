// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get prestApp => 'PrestApp';

  @override
  String get editar => 'Edit';

  @override
  String get eliminar => 'Delete';

  @override
  String get cancelar => 'Cancel';

  @override
  String get confirmar => 'Confirm';

  @override
  String get disponible => 'Available';

  @override
  String get prestado => 'Loaned';

  @override
  String get descripcionLabel => 'DESCRIPTION';

  @override
  String get ajustesTitulo => 'Settings';

  @override
  String get idioma => 'Language';

  @override
  String get espanol => 'Spanish';

  @override
  String get ingles => 'English';

  @override
  String get colorApp => 'App Color';

  @override
  String get colorAppSubtitulo => 'Choose your favorite paper tone.';

  @override
  String get modo => 'Mode';

  @override
  String get claro => 'Light';

  @override
  String get oscuro => 'Dark';

  @override
  String objetoDisponible(int count) {
    return 'Available item ($count)';
  }

  @override
  String get listaVacia => 'You don\'t have any items yet.\nTap + to add one.';

  @override
  String get detalleConfirmarDevolucionTitulo => 'Mark as returned?';

  @override
  String detalleConfirmarDevolucionTexto(String nombre) {
    return '$nombre will become available again.';
  }

  @override
  String prestadoDesde(String nombre, String fecha) {
    return 'Loaned to $nombre since $fecha';
  }

  @override
  String get marcarComoDevuelto => 'MARK AS RETURNED';

  @override
  String get prestarEsteObjeto => 'LEND THIS ITEM';

  @override
  String get nombreObligatorio => 'The item name is required';

  @override
  String get nuevoObjetoTitulo => 'New Item';

  @override
  String get agregarFoto => 'Add photo';

  @override
  String get guardarObjeto => 'Save Item';

  @override
  String get nombreObjetoHint => 'Item name';

  @override
  String get descripcionOpcionalHint => 'Description (optional)';

  @override
  String get eliminarObjetoTitulo => 'Delete item?';

  @override
  String get accionNoSePuedeDeshacer => 'This action cannot be undone';

  @override
  String get editarObjetoTitulo => 'Edit Item';

  @override
  String get cambiarFoto => 'Change photo';

  @override
  String get nombreObjetoLabel => 'ITEM NAME';

  @override
  String get guardarCambios => 'SAVE CHANGES';

  @override
  String get eliminarObjetoBoton => 'Delete Item';

  @override
  String get nombrePersonaObligatorio => 'Enter the person\'s name';

  @override
  String get propio => 'Own';

  @override
  String get prestarTitulo => 'Lend';

  @override
  String get aQuienSeLoPrestas => 'WHO ARE YOU LENDING IT TO?';

  @override
  String get escribeUnNombreHint => 'Type a name...';

  @override
  String get notasOpcional => 'NOTES (OPTIONAL)';

  @override
  String get notaHint => 'A reminder or the item\'s condition...';

  @override
  String get confirmarPrestamo => 'Confirm Loan';

  @override
  String get historialTitulo => 'History';

  @override
  String get sinPrestamos => 'You haven\'t recorded any loans yet.';

  @override
  String prestadoAPersona(String nombre) {
    return 'Loaned to $nombre';
  }

  @override
  String get devuelto => 'RETURNED';

  @override
  String get noSePuedeEliminarPrestado => 'A borrowed item cannot be deleted.';

  @override
  String get noSePuedeEditarPrestado =>
      'You cannot edit an article that is currently on loan';

  @override
  String get notaPrestado => 'Loan Note:';
}
