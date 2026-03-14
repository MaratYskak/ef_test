import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../characters/data/models/character_model.dart';

abstract class FavoritesLocalDataSource {
  Future<List<CharacterModel>> getFavorites();
  Future<void> addFavorite(CharacterModel character);
  Future<void> removeFavorite(int id);
  Future<bool> isFavorite(int id);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites(
            id INTEGER PRIMARY KEY,
            name TEXT,
            status TEXT,
            species TEXT,
            type TEXT,
            gender TEXT,
            originName TEXT,
            locationName TEXT,
            image TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<List<CharacterModel>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) => CharacterModel.fromDb(maps[i]));
  }

  @override
  Future<void> addFavorite(CharacterModel character) async {
    final db = await database;
    await db.insert(
      'favorites',
      character.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavorite(int id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<bool> isFavorite(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }
}
