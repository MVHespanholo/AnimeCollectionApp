import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/anime.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'anime_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: (db) async {
        await db.execute('PRAGMA encoding = "UTF-8"');
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE animes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        genre TEXT NOT NULL,
        episodes INTEGER NOT NULL,
        status TEXT NOT NULL,
        rating REAL NOT NULL,
        description TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        studio TEXT NOT NULL
      )
    ''');
  }

  // Inserir um novo anime
  Future<int> insertAnime(Anime anime) async {
    final Database db = await database;
    return await db.insert(
      'animes',
      anime.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Obter todos os animes
  Future<List<Anime>> getAnimes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('animes');

    return List.generate(maps.length, (i) {
      return Anime(
        id: maps[i]['id'],
        title: maps[i]['title'],
        genre: maps[i]['genre'],
        episodes: maps[i]['episodes'],
        status: maps[i]['status'],
        rating: maps[i]['rating'],
        description: maps[i]['description'],
        imageUrl: maps[i]['imageUrl'],
        studio: maps[i]['studio'],
      );
    });
  }

  // Atualizar um anime
  Future<int> updateAnime(Anime anime) async {
    final Database db = await database;
    return await db.update(
      'animes',
      anime.toMap(),
      where: 'id = ?',
      whereArgs: [anime.id],
    );
  }

  // Deletar um anime
  Future<int> deleteAnime(int id) async {
    final Database db = await database;
    return await db.delete(
      'animes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Obter um anime específico pelo ID
  Future<Anime?> getAnimeById(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'animes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Anime(
      id: maps[0]['id'],
      title: maps[0]['title'],
      genre: maps[0]['genre'],
      episodes: maps[0]['episodes'],
      status: maps[0]['status'],
      rating: maps[0]['rating'],
      description: maps[0]['description'],
      imageUrl: maps[0]['imageUrl'],
      studio: maps[0]['studio'],
    );
  }
}
