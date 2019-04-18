import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Cache,Source {
  Database _db;

  NewsDbProvider() {
    _open();
  }
  

  Future<Database> get db async{
    if(_db != null)
      return _db;
    _db = await _open();
    return _open();
    
  }
  
  Future<List<int>> fetchTopIds() {
    return null;
  }

  Future<Database> _open() async {
    io.Directory documentsDirectory =await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "imnjnjsp.db");
    var theDb = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate
      );
      return theDb;

  }
  
  void onCreate(Database newDb, int version) async {
        await newDb.execute("""
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTRGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        """
        );
   }
  
  
  Future<ItemModel> fetchItem(int id) async {
    var dbClient = await db;
    final maps = await dbClient.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id]);

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }
  Future<int> addItem(ItemModel item) async{
    var dbClient = await db;
    return await dbClient.insert(
      "Items",
       item.toMap(),
       conflictAlgorithm: ConflictAlgorithm.ignore);
  }
  Future<int> clear() {
    return _db.delete("Items");
  }
}

final newsDbProvider = NewsDbProvider();