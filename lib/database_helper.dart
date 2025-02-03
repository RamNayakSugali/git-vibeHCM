import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'data.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE data(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name1 TEXT,
            name2 TEXT,
            name3 TEXT
          )
        ''');
      },
    );
  }

  // Future<Database> _initDatabase() async {
  //   String path = join(await getDatabasesPath(), 'tasks.db');

  //   return await openDatabase(
  //     path,
  //     version: 1,
  //     onCreate: (db, version) async {
  //       await db.execute('''
  //         CREATE TABLE tasks(
  //           name location,
  //           name latitude,
  //           name longitude,
  //           isDone INTEGER
  //         )
  //       ''');
  //     },
  //   );
  // }

  // Future<void> insertTask(Task task) async {
  //   final db = await database;
  //   await db.insert('tasks', task.toMap());
  //   Fluttertoast.showToast(msg: "Added to data base Successfully");
  // }

  // Future<List<Task>> getaddress() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query('tasks');

  //   return List.generate(maps.length, (index) {
  //     return Task(
  //       location: maps[index]['name'],
  //       latitude: maps[index]['latitude'],
  //       longitude: maps[index]['longitude'],
  //       isDone: maps[index]['isDone'],
  //     );
  //   });
  // }
  // Future<void> insertData(Data data) async {
  //   final db = await database;
  //   await db.insert('data', data.toMap());
  // }
  Future<void> insertData(Data data) async {
    final db = await database;
    await db.insert('data', data.toMap());
  }

  Future<void> del(String name1) async {
    final db = await database;
    await db.delete('data', where: 'name1 = ?', whereArgs: [name1]);
  }

  // Future<void> deleteDatabase(String path) =>
  //   database.delete(path);
  //   Future<Database> _initDatabase() async {
  //   String path = join(await getDatabasesPath(), 'data.db');

  //   return await openDatabase(
  //     path,
  //     version: 1,
  //     onCreate: (db, version) async {
  //       await db.execute('''
  //         CREATE TABLE data(
  //           name1 TEXT,
  //           name2 TEXT,
  //           name3 TEXT
  //         )
  //       ''');
  //     },
  //   );
  // }

  // Future<List<Data>> getDataList() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query('data');

  //   return List.generate(maps.length, (index) {
  //     return Data(
  //       id: maps[index]['id'] as int, // Explicitly convert to int
  //       name1: maps[index]['name1'] as String,
  //       name2: maps[index]['name2'] as String,
  //       name3: maps[index]['name3'] as String,
  //     );
  //   });
  // }
  Future<List<Data>> getDataList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('data');

    return List.generate(maps.length, (index) {
      return Data(
        name1: maps[index]['name1'] as String,
        name2: maps[index]['name2'] as String,
        name3: maps[index]['name3'] as String,
      );
    });
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete('data', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
  // Future<List<Data>> getDataList() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query('data');

  //   return List.generate(maps.length, (index) {
  //     return Data(
  //       id: maps[index]['id'],
  //       name1: maps[index]['name1'],
  //       name2: maps[index]['name2'],
  //       name3: maps[index]['name3'],
  //     );
  //   });
  // }

  // Future<void> deleteTask(int id) async {
  //   final db = await database;
  //   await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  // }
}

class Data {
  String name1;
  String name2;
  String name3;

  Data({required this.name1, required this.name2, required this.name3});

  Map<String, dynamic> toMap() {
    return {'name1': name1, 'name2': name2, 'name3': name3};
  }
}
// class Data {
//   String name1;
//   String name2;
//   String name3;

//   Data({required this.name1, required this.name2, required this.name3});

//   Map<String, dynamic> toMap() {
//     return {'name1': name1, 'name2': name2, 'name3': name3};
//   }
// }

// class Task {
//   String location;
//   String latitude;
//   String longitude;
//   int isDone;

//   Task(
//       {required this.location,
//       required this.latitude,
//       required this.longitude,
//       this.isDone = 0});

//   Map<String, dynamic> toMap() {
//     return {
//       'location': location,
//       'latitude': latitude,
//       'longitude': longitude,
//       'isDone': isDone
//     };
//   }
// }
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static Database? _database;
//   static Database? _databaseURLS;
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

//   DatabaseHelper._privateConstructor();

//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await _initDatabase('locationtracking.db','''
//           CREATE TABLE locationtracking(
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             lat TEXT,
//             lon TEXT,
//             address TEXT
//           )
//         ''');
//     _databaseURLS = await _initDatabase('localurls.db','''
//           CREATE TABLE localurls(
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             devurl TEXT,
//             token TEXT,
//           )
//         ''');
//     return _database!;
//   }

//   Future<Database> _initDatabase(String dbName,String careteTable) async {
//     String path = join(await getDatabasesPath(), dbName);

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute(careteTable);
//       },
//     );
//   }

//   // Future<Database> _initDatabase() async {
//   //   String path = join(await getDatabasesPath(), 'tasks.db');

//   //   return await openDatabase(
//   //     path,
//   //     version: 1,
//   //     onCreate: (db, version) async {
//   //       await db.execute('''
//   //         CREATE TABLE tasks(
//   //           name location,
//   //           name latitude,
//   //           name longitude,
//   //           isDone INTEGER
//   //         )
//   //       ''');
//   //     },
//   //   );
//   // }

//   // Future<void> insertTask(Task task) async {
//   //   final db = await database;
//   //   await db.insert('tasks', task.toMap());
//   //   Fluttertoast.showToast(msg: "Added to data base Successfully");
//   // }

//   // Future<List<Task>> getaddress() async {
//   //   final db = await database;
//   //   final List<Map<String, dynamic>> maps = await db.query('tasks');

//   //   return List.generate(maps.length, (index) {
//   //     return Task(
//   //       location: maps[index]['name'],
//   //       latitude: maps[index]['latitude'],
//   //       longitude: maps[index]['longitude'],
//   //       isDone: maps[index]['isDone'],
//   //     );
//   //   });
//   // }
//   // Future<void> insertData(Data data) async {
//   //   final db = await database;
//   //   await db.insert('data', data.toMap());
//   // }
//   Future<void> insertData(Data data) async {
//     final db = await database;
//     await db.insert('data', data.toMap());
//   }
//   //   Future<Database> _initDatabase() async {
//   //   String path = join(await getDatabasesPath(), 'data.db');

//   //   return await openDatabase(
//   //     path,
//   //     version: 1,
//   //     onCreate: (db, version) async {
//   //       await db.execute('''
//   //         CREATE TABLE data(
//   //           name1 TEXT,
//   //           name2 TEXT,
//   //           name3 TEXT
//   //         )
//   //       ''');
//   //     },
//   //   );
//   // }

//   // Future<List<Data>> getDataList() async {
//   //   final db = await database;
//   //   final List<Map<String, dynamic>> maps = await db.query('data');

//   //   return List.generate(maps.length, (index) {
//   //     return Data(
//   //       id: maps[index]['id'] as int, // Explicitly convert to int
//   //       name1: maps[index]['name1'] as String,
//   //       name2: maps[index]['name2'] as String,
//   //       name3: maps[index]['name3'] as String,
//   //     );
//   //   });
//   // }
//   Future<List<Data>> getDataList() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('data');

//     return List.generate(maps.length, (index) {
//       return Data(
//         lat: maps[index]['lat'] as String,
//         lon: maps[index]['lon'] as String,
//         address: maps[index]['address'] as String,
//       );
//     });
//   }
//   // Future<List<Data>> getDataList() async {
//   //   final db = await database;
//   //   final List<Map<String, dynamic>> maps = await db.query('data');

//   //   return List.generate(maps.length, (index) {
//   //     return Data(
//   //       id: maps[index]['id'],
//   //       name1: maps[index]['name1'],
//   //       name2: maps[index]['name2'],
//   //       name3: maps[index]['name3'],
//   //     );
//   //   });
//   // }

//   // Future<void> deleteTask(int id) async {
//   //   final db = await database;
//   //   await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
//   // }
// }

// class Data {
//   String lat;
//   String lon;
//   String address;

//   Data({required this.lat, required this.lon, required this.address});

//   Map<String, dynamic> toMap() {
//     return {'name1': lat, 'name2': lon, 'name3': address};
//   }
// }
// // class Data {
// //   String name1;
// //   String name2;
// //   String name3;

// //   Data({required this.name1, required this.name2, required this.name3});

// //   Map<String, dynamic> toMap() {
// //     return {'name1': name1, 'name2': name2, 'name3': name3};
// //   }
// // }

// // class Task {
// //   String location;
// //   String latitude;
// //   String longitude;
// //   int isDone;

// //   Task(
// //       {required this.location,
// //       required this.latitude,
// //       required this.longitude,
// //       this.isDone = 0});

// //   Map<String, dynamic> toMap() {
// //     return {
// //       'location': location,
// //       'latitude': latitude,
// //       'longitude': longitude,
// //       'isDone': isDone
// //     };
// //   }
// // }
