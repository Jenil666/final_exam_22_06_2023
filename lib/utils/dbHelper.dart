import 'dart:io';
import 'package:get/get.dart';
// import 'package:income_expense_app/screen/home/controller/homecontroller.dart';
// import 'package:income_expense_app/screen/transactionscreen/controller/transaction_controller.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DbHelper
{
  static DbHelper dbHelper = DbHelper._();
  DbHelper._();
  Database? database;

   String tableName = "todo";
   String c_id = "id";
   String c_task = "task";
   String c_type = "type";
   String c_title = "title";

  checkDb()
  async {
    if (database == null) {
      return await createDatabase();
    } else {
      return database;
    }
  }

  createDatabase()
  async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'table2.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query = "CREATE TABLE $tableName($c_id INTEGER PRIMARY KEY AUTOINCREMENT,$c_task Text,$c_type Text,$c_title Text)";
        db.execute(query);
      },
    );
  }

  Future<void> insertDatabase(
      {required task,
        required type,
        required title,
      }) async {
    database = await checkDb();
    database!.insert("$tableName", {
      '$c_task': task,
      '$c_type': type,
      '$c_title': title,
    });
  }

  Future<List<Map>> readDatabase() async {
    database = await checkDb();
    String sql = 'SELECT * FROM $tableName';
    List<Map> list = await database!.rawQuery(sql);
    return list;
  }

  Future<void> updateDatabase(
      {required type,
        required title,
        required task,
        required id,
      }) async {
    database = await checkDb();
    database!.update(
        '$tableName',
        {
          "$c_type":"$type",
          "$c_title":"$title",
          "$c_task":"$task",
        },
        where: 'id=?',
        whereArgs: [id]);
  }

  Future<void> deleteDatabase({required id}) async {
    database = await checkDb();
    database!.delete('$tableName', where: "id=?", whereArgs: [id]);
  }

}