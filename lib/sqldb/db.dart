// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:apptvshow/constant.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) return _db;

    _db = await initDb();
    return _db;
  }

  initDb() async {
    String pathDatatB = await getDatabasesPath(); // مسار الحفظ
    String path = join(pathDatatB, 'ahmed.db'); // اسم الداتا بيز
    Database mydb = await openDatabase(path,
        onCreate: _oncareate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldv, int newv) {
    print("_onUpgrade ==============");
  }

  _oncareate(Database db, int v) async {
    await db.execute(''' 
      CREATE TABLE $ahmed(
       $channelId INTEGER NOT NULL, 
       $channelName TEXT NOT NULL,
       $channelImage TEXT NOT NULL,
       $channelUrl TEXT NOT NULL,
       $channelType TEXT NOT NULL,
       $channelDescription TEXT NOT NULL,
       $videoId TEXT NOT NULL,
       $categoryName TEXT NOT NULL,
       $userAgent TEXT NOT NULL


      )
      
      ''');
    await db.execute(''' 
      CREATE TABLE $ch(
       $channelId INTEGER NOT NULL, 
       $channelName TEXT NOT NULL,
       $channelImage TEXT NOT NULL,
       $channelUrl TEXT NOT NULL,
       $channelType TEXT NOT NULL,
       $userAgent TEXT NOT NULL,
       $channelDescription TEXT NOT NULL,
       $categoryName TEXT NOT NULL,
       $videoId TEXT NOT NULL
      )
      
      ''');
    print("CREATE TABLE 33222222222222222222222222222222222 ==============");
  }

  reddata(String sql) async {
    Database? mydb = await db;
    Future<List<Map>> respons = mydb!.rawQuery(sql);
    print("reddata ==============");
    return respons;
  }

  insertdata(String sql) async {
    Database? mydb = await db;
    Future<int> respons = mydb!.rawInsert(sql);
    print("insertdata ==============");
    return respons;
  }

  updatedata(String sql) async {
    Database? mydb = await db;
    Future<int> respons = mydb!.rawUpdate(sql);
    return respons;
  }

  deletedata(String sql) async {
    Database? mydb = await db;
    Future<int> respons = mydb!.rawDelete(sql);
    return respons;
  }

  ///
  red(String sql) async {
    Database? mydb = await db;
    Future<List<Map>> respons = mydb!.query(sql);
    print("reddata ==============");
    return respons;
  }

  insert(String sql, Map<String, Object?> values) async {
    /////////////////////////////
    Database? mydb = await db;
    Future<int> respons = mydb!.insert(sql, values);
    print("insertdata ==============");
    return respons;
  }

  update(String sql, Map<String, Object?> values, String? mywhere) async {
    Database? mydb = await db;
    Future<int> respons = mydb!.update(sql, values, where: mywhere);
    return respons;
  }

  delete(String sql, String? where) async {
    Database? mydb = await db;
    Future<int> respons = mydb!.delete(sql, where: where);
    return respons;
  }
}
