import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constant/db_constant.dart';
import '../models/restaurant.dart';

class RestaurantDatabase {
  static final RestaurantDatabase instance = RestaurantDatabase._init();

  static late Database _database;

  RestaurantDatabase._init();

  Future<Database> get database async {
    _database = await _initializeDb('restaurant_db.db');
    return _database;
  }

  Future<Database> _initializeDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: dbVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE $tableRestaurant (
        ${RestaurantField.id} $idType, 
        ${RestaurantField.name} $textType,
        ${RestaurantField.description} $textType,
        ${RestaurantField.pictureId} $textType,
        ${RestaurantField.city} $textType,
        ${RestaurantField.rating} $doubleType
      )''',
    );
  }

  Future<void> addRestaurant(dynamic json) async {
    final Database db = await database;
    await db.insert(tableRestaurant, json);
  }

  Future<List<dynamic>> getRestaurants() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(tableRestaurant);

    return results.toList();
  }

  Future<dynamic> getRestaurantById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      tableRestaurant,
      where: '${RestaurantField.id} = ?',
      whereArgs: [id],
    );

    return results.first;
  }

  Future<void> updateRestaurant(Restaurant restaurant) async {
    final db = await database;
    await db.update(
      tableRestaurant,
      restaurant.toJson(),
      where: '${RestaurantField.id} = ?',
      whereArgs: [restaurant.id],
    );
  }

  Future<void> deleteRestaurant(String id) async {
    final db = await database;
    await db.delete(
      tableRestaurant,
      where: '${RestaurantField.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}