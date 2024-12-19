import 'package:sqflite/sqflite.dart';

import '../../database/local/database_helper.dart';

class Student {
  int? id;
  String name;
  String department;
  Student({this.id, required this.name, required this.department});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'department': department,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    //print("Inside factory $map");
    return Student(
        id: map['id'] as int?,
        name: map['name'] ?? "No Name Found",
        department : map['department'] ?? "No Department Found",
    );
  }
}

class StudentTableProvider{

  static const String createTable = '''
      CREATE TABLE student (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        department TEXT NOT NULL
      )
    ''';

  static Future<List<Map<String, dynamic>>> queryAllStudents() async {
    Database db = await DatabaseHelper.db;
    return await db.query('student');
  }

  static Future<void> insertStudent(Student std) async {
    Database db = await DatabaseHelper.db;
    await db.insert('student', std.toMap());
  }

  static Future<void> updateStudent(Student std) async {
    Database db = await DatabaseHelper.db;
    await db.update('student', std.toMap(), where: 'id = ?', whereArgs: [std.id]);
  }

  static Future<void> deleteStudent(int id) async {
    Database db = await DatabaseHelper.db;
    await db.delete('student', where: 'id = ?', whereArgs: [id]);
  }
}