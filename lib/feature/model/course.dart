import 'package:sqflite/sqflite.dart';

import '../../database/local/database_helper.dart';

class Course {
  int? id;
  String courseName;
  String courseCode;
  Course({this.id, required this.courseName, required this.courseCode});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseName': courseName,
      'courseCode': courseCode,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    //print("Inside factory $map");
    return Course(
        id: map['id'] as int?,
        courseName: map['courseName'] ?? "No Course Name Found",
        courseCode : map['courseCode'] ?? "No Course Code Found",
    );
  }
}

class CourseTableProvider{

  static const String createTable = '''
      CREATE TABLE course (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        courseName TEXT NOT NULL,
        courseCode TEXT NOT NULL
      )
    ''';

  static Future<List<Map<String, dynamic>>> queryAllCourse() async {
    Database db = await DatabaseHelper.db;
    return await db.query('course');
  }

  static Future<void> insertCourse(Course subject) async {
    Database db = await DatabaseHelper.db;
    await db.insert('course', subject.toMap());
  }

  static Future<void> updateCourse(Course subject) async {
    Database db = await DatabaseHelper.db;
    await db.update('course', subject.toMap(), where: 'id = ?', whereArgs: [subject.id]);
  }

  static Future<void> deleteCourse(int id) async {
    Database db = await DatabaseHelper.db;
    await db.delete('course', where: 'id = ?', whereArgs: [id]);
  }
}