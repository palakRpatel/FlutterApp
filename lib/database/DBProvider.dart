import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:jaibahuchar/utilities/MySharePreference.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static final DBProvider _instance = new DBProvider.internal();

  factory DBProvider() => _instance;
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  DBProvider.internal();

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    MySharePreference pref=MySharePreference();
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "app.db");
    if (!await pref.getIsFirstLoad()) {
      await pref.setIsFirstTimeLoad();
      await deleteDatabase(path);
      ByteData data = await rootBundle.load("assets/db/jai_bahuchar.sqlite");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }
    _database = await openDatabase(path);
    return _database;
  }

}
