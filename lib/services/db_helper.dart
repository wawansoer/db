import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/item.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper();
  factory DbHelper() => _instance;

  // static Database? _database;

  Future<Database> get database async {
    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'items.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
      )
      ''');
  }

  Future<List<Item>> getItems() async {
    Database db = await database;

    List<Map<String, dynamic>> maps = await db.query('items');

    return List.generate(maps.length, (i) {
      return Item.fromMap(maps[i]);
    });
  }

  Future<int> insterItem(Item item) async {
    Database db = await database;
    return await db.insert('items', item.toMap());
  }

  Future<int> updateItem(Item item) async {
    Database db = await database;
    return await db
        .update('items', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  Future<int> deleteItem(int id) async {
    Database db = await database;
    return await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }
}
