// Elias Mariñez, 2022-1073
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vigilapp_20221073/models/incident_model.dart';

class DatabaseHelper{
  // Definicion del Singleton DatabaseHelper
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  // Retorno de la base de datos, en caso de ser nula, la inicializa.
  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializacion de la base datos, definicion de ruta, version, y creacion de la misma.
  Future<Database> _initDatabase() async{
    final path = join(await getDatabasesPath(), 'surveillance.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      );
  }

  // Creacion de la tabla incidents
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE incidents (
        id INTEGER PRIMARY KEY,
        title TEXT,
        date TEXT,
        description TEXT,
        photo TEXT,
        audio TEXT
      )
    ''');
  }

  Future<int> insertIncident(Incident incident) async {
    Database db = await database;
    return await db.insert('incidents', incident.toMap());
  }

  Future<List<Incident>> getIncidents() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'incidents', 
      orderBy: 'date DESC'
    );

    return List.generate(maps.length, (i) {
      return Incident.fromMap(maps[i]);
    });
  }

  Future<int> deleteAllIncidents() async {
    Database db = await database;
    return await db.delete('incidents');
  }
}