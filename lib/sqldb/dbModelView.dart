// ignore_for_file: avoid_print, file_names

import 'package:apptvshow/constant.dart';
import 'package:apptvshow/sqldb/db.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class DBModelView extends GetxController {
  // DBModelView() {
  //   reddate();
  // }
  SqlDb sqlDb = SqlDb();
  List get dbmovies => _dbmovies;
  final List _dbmovies = [];
  List get ch2 => _ch2;
  final List _ch2 = [];

  Future reddate() async {
    // List a = await sqlDb.reddata("SELECT * FROM notes");
    List a = await sqlDb.red("ahmed");
    List p = await sqlDb.red("ch");

    _dbmovies.addAll(a);
    _ch2.addAll(p);

    print(_dbmovies.length);
    print("+++++++++++++++++++++++++++");

    update();
  }

  ch(int id, String web) {
    if (web == detail) {
      for (int i = 0; i < _dbmovies.length; i++) {
        if (id == _dbmovies[i]["channelId"]) {
          return true;
        }
      }
    } else {
      for (int i = 0; i < _ch2.length; i++) {
        if (id == _ch2[i]["channelId"]) {
          return true;
        }
      }
    }
  }

  insert(String sql, Map<String, Object?> values, int id) async {
    /////////////////////////////
    ///
    for (int i = 0; i < _dbmovies.length; i++) {
      if (id == _dbmovies[i]["channelId"]) {
        return;
      }
    }
    Database? mydb = await sqlDb.db;
    Future<int> respons = mydb!.insert(sql, values);
    _dbmovies.add(values);
    print("insertdata ==============");
    update();
    return respons;
  }

  insert2(String sql, Map<String, Object?> values, int id) async {
    /////////////////////////////
    ///
    for (int i = 0; i < ch2.length; i++) {
      if (id == ch2[i]["channelId"]) {
        return;
      }
    }
    Database? mydb = await sqlDb.db;
    Future<int> respons = mydb!.insert(sql, values);
    ch2.add(values);
    print("insertdata ==============");
    update();
    return respons;
  }

  /////////////////////////////////

  delete(String sql, String? where, index2) async {
    Database? mydb = await sqlDb.db;
    Future<int> respons = mydb!.delete(sql, where: where);
    _dbmovies.remove(index2);
    update();
    return respons;
  }

  delete2(String sql, String? where, index2) async {
    Database? mydb = await sqlDb.db;
    Future<int> respons = mydb!.delete(sql, where: where);
    _ch2.remove(index2);
    update();
    return respons;
  }
}
