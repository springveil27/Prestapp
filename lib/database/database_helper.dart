import 'package:prestapp/models/Prestamo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/Articulo_model.dart';

/// Helper singleton para acceso a la base de datos SQLite de PrestApp.
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // singleton para asegurar una sola instancia en la base de dato
  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'Articulos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Articulos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    descripcion TEXT NOT NULL,
    imagen TEXT
    );
    ''');

    await db.execute(''' CREATE TABLE Prestamos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    idArticulo INTEGER NOT NULL,
    nombrePersona TEXT NOT NULL,
    fechaPrestamo TEXT NOT NULL,
    fechaDevolucion TEXT,
    nota TEXT,
    FOREIGN KEY (idArticulo) REFERENCES Articulos (id) ON DELETE CASCADE);
    ''');
  }

  //CRUD para articulos
  Future<int> crearArticulo(Articulo articulo) async {
    final db = await database;
    return await db.insert('Articulos', articulo.toMap());
  }

  // Trae todos los artículos junto con el préstamo ACTIVO (si existe).
  Future<List<Articulo>> getAllArticulos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
SELECT a.id,
a.nombre,
a.descripcion,
a.imagen,
p.nombrePersona,
p.fechaPrestamo
FROM Articulos as a
LEFT JOIN Prestamos as p
  ON a.id = p.idArticulo AND p.fechaDevolucion IS NULL
''');
    return List.generate(maps.length, (i) {
      return Articulo.fromMap(maps[i]);
    });
  }

  Future<int> editarArticulo(Articulo articulo) async {
    final db = await database;
    return await db.update(
      'Articulos',
      articulo.toMap(),
      where: 'id = ?',
      whereArgs: [articulo.id],
    );
  }

  Future<int> eliminarArticulo(int id) async {
    final db = await database;
    return await db.delete('Articulos', where: 'id = ?', whereArgs: [id]);
  }

  //CRUD para prestamos
  Future<int> crearPrestamo(Prestamo prestamo) async {
    final db = await database;
    return await db.insert('Prestamos', prestamo.toMap());
  }

  Future<List<Prestamo>> getAllPrestamos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Prestamos');
    return List.generate(maps.length, (i) {
      return Prestamo.fromMap(maps[i]);
    });
  }

  Future<Prestamo?> getPrestamoActivo(int idArticulo) async {
    final db = await database;
    final maps = await db.query(
      'Prestamos',
      where: 'idArticulo = ? AND fechaDevolucion IS NULL',
      whereArgs: [idArticulo],
      orderBy: 'fechaPrestamo DESC',
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return Prestamo.fromMap(maps.first);
  }

  Future<int> DevolverPrestamo(int id) async {
    final db = await database;
    final fechaDevolucion = DateTime.now().toIso8601String();

    return await db.update(
      'Prestamos',
      {'fechaDevolucion': fechaDevolucion},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Prestamo>> getHistorialPrestamos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT p.*, a.nombre as nombreArticulo, a.imagen as imagenArticulo
      FROM Prestamos p
      INNER JOIN Articulos a ON p.idArticulo = a.id
      ORDER BY p.fechaPrestamo DESC
    ''');
    return List.generate(maps.length, (i) {
      return Prestamo.fromMap(maps[i]);
    });
  }
}
