import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @prestApp.
  ///
  /// In es, this message translates to:
  /// **'PrestApp'**
  String get prestApp;

  /// No description provided for @editar.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get editar;

  /// No description provided for @eliminar.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get eliminar;

  /// No description provided for @cancelar.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancelar;

  /// No description provided for @confirmar.
  ///
  /// In es, this message translates to:
  /// **'Confirmar'**
  String get confirmar;

  /// No description provided for @disponible.
  ///
  /// In es, this message translates to:
  /// **'Disponible'**
  String get disponible;

  /// No description provided for @prestado.
  ///
  /// In es, this message translates to:
  /// **'Prestado'**
  String get prestado;

  /// No description provided for @descripcionLabel.
  ///
  /// In es, this message translates to:
  /// **'DESCRIPCIÓN'**
  String get descripcionLabel;

  /// No description provided for @ajustesTitulo.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get ajustesTitulo;

  /// No description provided for @idioma.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get idioma;

  /// No description provided for @espanol.
  ///
  /// In es, this message translates to:
  /// **'Español'**
  String get espanol;

  /// No description provided for @ingles.
  ///
  /// In es, this message translates to:
  /// **'Inglés'**
  String get ingles;

  /// No description provided for @colorApp.
  ///
  /// In es, this message translates to:
  /// **'Color de la App'**
  String get colorApp;

  /// No description provided for @colorAppSubtitulo.
  ///
  /// In es, this message translates to:
  /// **'Elige tu tono de papel preferido.'**
  String get colorAppSubtitulo;

  /// No description provided for @modo.
  ///
  /// In es, this message translates to:
  /// **'Modo'**
  String get modo;

  /// No description provided for @claro.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get claro;

  /// No description provided for @oscuro.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get oscuro;

  /// No description provided for @objetoDisponible.
  ///
  /// In es, this message translates to:
  /// **'Objeto disponible ({count})'**
  String objetoDisponible(int count);

  /// No description provided for @listaVacia.
  ///
  /// In es, this message translates to:
  /// **'Aún no tienes artículos.\nToca + para agregar uno.'**
  String get listaVacia;

  /// No description provided for @detalleConfirmarDevolucionTitulo.
  ///
  /// In es, this message translates to:
  /// **'¿Marcar como devuelto?'**
  String get detalleConfirmarDevolucionTitulo;

  /// No description provided for @detalleConfirmarDevolucionTexto.
  ///
  /// In es, this message translates to:
  /// **'{nombre} volverá a estar disponible.'**
  String detalleConfirmarDevolucionTexto(String nombre);

  /// No description provided for @prestadoDesde.
  ///
  /// In es, this message translates to:
  /// **'Prestado a {nombre} desde el {fecha}'**
  String prestadoDesde(String nombre, String fecha);

  /// No description provided for @marcarComoDevuelto.
  ///
  /// In es, this message translates to:
  /// **'MARCAR COMO DEVUELTO'**
  String get marcarComoDevuelto;

  /// No description provided for @prestarEsteObjeto.
  ///
  /// In es, this message translates to:
  /// **'PRESTAR ESTE OBJETO'**
  String get prestarEsteObjeto;

  /// No description provided for @nombreObligatorio.
  ///
  /// In es, this message translates to:
  /// **'El nombre del objeto es obligatorio'**
  String get nombreObligatorio;

  /// No description provided for @nuevoObjetoTitulo.
  ///
  /// In es, this message translates to:
  /// **'Nuevo Objeto'**
  String get nuevoObjetoTitulo;

  /// No description provided for @agregarFoto.
  ///
  /// In es, this message translates to:
  /// **'Agregar foto'**
  String get agregarFoto;

  /// No description provided for @guardarObjeto.
  ///
  /// In es, this message translates to:
  /// **'Guardar Objeto'**
  String get guardarObjeto;

  /// No description provided for @nombreObjetoHint.
  ///
  /// In es, this message translates to:
  /// **'Nombre del objeto'**
  String get nombreObjetoHint;

  /// No description provided for @descripcionOpcionalHint.
  ///
  /// In es, this message translates to:
  /// **'Descripción (opcional)'**
  String get descripcionOpcionalHint;

  /// No description provided for @eliminarObjetoTitulo.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar objeto?'**
  String get eliminarObjetoTitulo;

  /// No description provided for @accionNoSePuedeDeshacer.
  ///
  /// In es, this message translates to:
  /// **'Esta acción no se puede deshacer'**
  String get accionNoSePuedeDeshacer;

  /// No description provided for @editarObjetoTitulo.
  ///
  /// In es, this message translates to:
  /// **'Editar Objeto'**
  String get editarObjetoTitulo;

  /// No description provided for @cambiarFoto.
  ///
  /// In es, this message translates to:
  /// **'Cambiar foto'**
  String get cambiarFoto;

  /// No description provided for @nombreObjetoLabel.
  ///
  /// In es, this message translates to:
  /// **'NOMBRE DEL OBJETO'**
  String get nombreObjetoLabel;

  /// No description provided for @guardarCambios.
  ///
  /// In es, this message translates to:
  /// **'GUARDAR CAMBIOS'**
  String get guardarCambios;

  /// No description provided for @eliminarObjetoBoton.
  ///
  /// In es, this message translates to:
  /// **'Eliminar Objeto'**
  String get eliminarObjetoBoton;

  /// No description provided for @nombrePersonaObligatorio.
  ///
  /// In es, this message translates to:
  /// **'Escribe el nombre de la persona'**
  String get nombrePersonaObligatorio;

  /// No description provided for @propio.
  ///
  /// In es, this message translates to:
  /// **'Propio'**
  String get propio;

  /// No description provided for @prestarTitulo.
  ///
  /// In es, this message translates to:
  /// **'Prestar'**
  String get prestarTitulo;

  /// No description provided for @aQuienSeLoPrestas.
  ///
  /// In es, this message translates to:
  /// **'¿A QUIÉN SE LO PRESTAS?'**
  String get aQuienSeLoPrestas;

  /// No description provided for @escribeUnNombreHint.
  ///
  /// In es, this message translates to:
  /// **'Escribe un nombre...'**
  String get escribeUnNombreHint;

  /// No description provided for @notasOpcional.
  ///
  /// In es, this message translates to:
  /// **'NOTAS (OPCIONAL)'**
  String get notasOpcional;

  /// No description provided for @notaHint.
  ///
  /// In es, this message translates to:
  /// **'Algún recordatorio o estado del objeto...'**
  String get notaHint;

  /// No description provided for @confirmarPrestamo.
  ///
  /// In es, this message translates to:
  /// **'Confirmar Préstamo'**
  String get confirmarPrestamo;

  /// No description provided for @historialTitulo.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get historialTitulo;

  /// No description provided for @sinPrestamos.
  ///
  /// In es, this message translates to:
  /// **'Aún no has registrado préstamos.'**
  String get sinPrestamos;

  /// No description provided for @prestadoAPersona.
  ///
  /// In es, this message translates to:
  /// **'Prestado a {nombre}'**
  String prestadoAPersona(String nombre);

  /// No description provided for @devuelto.
  ///
  /// In es, this message translates to:
  /// **'DEVUELTO'**
  String get devuelto;

  /// No description provided for @noSePuedeEliminarPrestado.
  ///
  /// In es, this message translates to:
  /// **'No se puede eliminar un artículo que está prestado.'**
  String get noSePuedeEliminarPrestado;

  /// No description provided for @noSePuedeEditarPrestado.
  ///
  /// In es, this message translates to:
  /// **'No se puede editar un articulo que esta prestado'**
  String get noSePuedeEditarPrestado;

  /// No description provided for @notaPrestado.
  ///
  /// In es, this message translates to:
  /// **'Nota de Prestamo:'**
  String get notaPrestado;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
