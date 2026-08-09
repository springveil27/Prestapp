import '../models/Articulo_model.dart';
import '../database/database_helper.dart';
import 'package:image_picker/image_picker.dart';

class ArticuloController {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final ImagePicker _picker = ImagePicker();
  List<Articulo> articulos = [];

  String? imageTemp;

  Future<void> SeleccionarImagen() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (image != null) {
      imageTemp = image.path;
    }
  }

  Future<void> CargarArticulos() async {
    articulos = await _databaseHelper.getAllArticulos();
  }

  Future<void> aggArticulo(String nombre, String descripcion) async {
    final newArticulo = Articulo(
      nombre: nombre,
      descripcion: descripcion,
      imagen: imageTemp,
    );
    await _databaseHelper.crearArticulo(newArticulo);
    imageTemp = null;
    await CargarArticulos();
  }

  Future<void> editarArticulo(Articulo articulo) async {
    await _databaseHelper.editarArticulo(articulo);
    await CargarArticulos();
  }

  Future<void> EliminarArticulo(int id) async {
    await _databaseHelper.eliminarArticulo(id);
    await CargarArticulos();
  }
}
