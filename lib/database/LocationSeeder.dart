import 'dart:core';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocationSeeder {
  /// variable
  static const dbName = "location.db";
  static const dbVersion = 1;
  static const dbTable = "location";
  static const rowId = "id";

  ///constructor
  static final LocationSeeder instance = LocationSeeder();

  ///database Initialise
  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  // /// Setting Table Create
  Future onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $dbTable (id INTEGER PRIMARY KEY,key VARCHAR NOT NULL,value VARCHAR NOT NULL,groupValue VARCHAR NOT NULL)");
  }

  ///INSERT METHOD
  /// Example:
  /// _______________
  /// LocationSeeder.instance.insertRecord({'key': "lon", "value": 0, "groupValue": "coordinate"});
  ///_______________
  ///
  insertRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    var chk = await LocationSeeder.instance.readRow(row['key']);
    // log.w(chk.length);
    if (chk.length == 0) {
      return db!.insert(dbTable, row);
    }
  }

  /// Read / quire method
  ///
  /// Example:
  /// _______________
  /// LocationSeeder.instance.queryRecord();
  ///_______________
  ///
  Future<List<Map<String, dynamic>>> queryRecord() async {
    Database? db = await instance.database;
    return await db!.query(dbTable);
  }

  Future<List<Map<String, dynamic>>> readData(String key) async {
    Database? db = await instance.database;
    return await db!.query(dbTable, where: 'groupValue = ?', whereArgs: [key]);
  }

  Future<List<Map<String, dynamic>>> readRow(String key) async {
    Database? db = await instance.database;
    return await db!.query(dbTable, where: 'key = ?', whereArgs: [key], limit: 1);
  }

  /// Update Method
  ///
  /// Example:
  /// _______________
  /// LocationSeeder.instance.updateRecord({"id": 3, 'key': "lon", "value": 0, "groupValue": "coordinate"});
  ///_______________
  ///
  Future<int> updateRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int rId = row[rowId];
    return await db!.update(dbTable, row, where: "$rowId = ?", whereArgs: [rId]);
  }

  /// Delete Method
  ///
  /// Example:
  /// _______________
  /// LocationSeeder.instance.deleteRecord(id);
  ///_______________
  ///
  Future<int> deleteRecord(int id) async {
    Database? db = await instance.database;
    return await db!.delete(dbTable, where: '$rowId = ?', whereArgs: [id]);
  }

  // /// SEED
  static void updateLocationSeed(var data) {
    ///Current Location
    LocationSeeder.instance.updateRecord({"id": 1, 'key': "address", "value": data.coord!.ad, "groupValue": "currentLocation"});
    LocationSeeder.instance.updateRecord({"id": 2, 'key': "lat", "value": data.coord!.lat, "groupValue": "currentLocation"});
    LocationSeeder.instance.updateRecord({"id": 2, 'key': "lon", "value": data.coord!.lat, "groupValue": "currentLocation"});

    ///Destination Location
    LocationSeeder.instance.updateRecord({"id": 4, 'key': "address", "value": data.country, "groupValue": "destinationLocation"});
    LocationSeeder.instance.updateRecord({"id": 5, 'key': "lat", "value": data.name, "groupValue": "destinationLocation"});
    LocationSeeder.instance.updateRecord({"id": 6, 'key': "lon", "value": data.country, "groupValue": "destinationLocation"});
  }

  // /// SEED
  static void locationSeed() {
    ///Current Location
    LocationSeeder.instance.insertRecord({'key': "address", "value": 0, "groupValue": "currentLocation"});
    LocationSeeder.instance.insertRecord({'key': "lat", "value": 0, "groupValue": "currentLocation"});
    LocationSeeder.instance.insertRecord({'key': "lon", "value": 0, "groupValue": "currentLocation"});
     ///Destination Location
    LocationSeeder.instance.insertRecord({'key': "address", "value": 0, "groupValue": "destinationLocation"});
    LocationSeeder.instance.insertRecord({'key': "lat", "value": 0, "groupValue": "destinationLocation"});
    LocationSeeder.instance.insertRecord({'key': "lon", "value": 0, "groupValue": "destinationLocation"});
  }
}
