class Prestamo {
  int? id;
  int? idArticulo;
  String nombrePersona;
  String fechaPrestamo;
  String? fechaDevolucion;
  String? nota;

  // Vienen del JOIN de getHistorialPrestamos() y no se guardan con toMap().
  final String? nombreArticulo;
  final String? imagenArticulo;

  Prestamo({
    this.id,
    this.idArticulo,
    required this.nombrePersona,
    required this.fechaPrestamo,
    this.fechaDevolucion,
    this.nota,
    this.nombreArticulo,
    this.imagenArticulo,
  });

  bool get estaDevuelto => fechaDevolucion != null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idArticulo': idArticulo,
      'nombrePersona': nombrePersona,
      'fechaPrestamo': fechaPrestamo,
      'fechaDevolucion': fechaDevolucion,
      'nota': nota,
    };
  }

  factory Prestamo.fromMap(Map<String, dynamic> map) {
    return Prestamo(
      id: map['id'],
      idArticulo: map['idArticulo'],
      nombrePersona: map['nombrePersona'],
      fechaPrestamo: map['fechaPrestamo'],
      fechaDevolucion: map['fechaDevolucion'],
      nota: map['nota'],
      nombreArticulo: map['nombreArticulo'],
      imagenArticulo: map['imagenArticulo'],
    );
  }
}
