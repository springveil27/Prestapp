//clase articuo
class Articulo {
  int? id;
  String nombre;
  String descripcion;
  String? imagen;

  //datos extra de prestamos para la ui
  final String? nombrePersona;
  final String? fechaPrestamo;

  Articulo({
    this.id,
    required this.nombre,
    required this.descripcion,
    this.imagen,
    this.nombrePersona,
    this.fechaPrestamo,
  });

  bool get estaPrestado => nombrePersona != null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'imagen': imagen,
    };
  }

  factory Articulo.fromMap(Map<String, dynamic> map) {
    return Articulo(
      id: map['id'],
      nombre: map["nombre"],
      descripcion: map["descripcion"],
      imagen: map["imagen"],
      nombrePersona: map["nombrePersona"],
      fechaPrestamo: map["fechaPrestamo"],
    );
  }
}
