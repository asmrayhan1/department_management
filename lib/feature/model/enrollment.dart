import 'package:sqflite/sqflite.dart';

import '../../database/local/database_helper.dart';

class Enrollment {
  int? id;
  int studentId;
  int courseId;
  Enrollment({this.id, required this.studentId, required this.courseId});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'courseId': courseId,
    };
  }

  factory Enrollment.fromMap(Map<String, dynamic> map) {
    //print("Inside factory $map");
    return Enrollment(
        id: map['id'] as int?,
        studentId: map['studentId'] ?? 0,
        courseId : map['courseId'] ?? 0,
    );
  }
}

class EnrollmentTableProvider{

  static const String createTable = '''
      CREATE TABLE enrollments (
        studentId INTEGER, 
        courseId INTEGER,
        FOREIGN KEY(studentId) REFERENCES students(id) ON DELETE CASCADE,
        FOREIGN KEY(courseId) REFERENCES courses(id) ON DELETE CASCADE,
        PRIMARY KEY(studentId, courseId)
      )
    ''';

  static Future<List<Map<String, dynamic>>> queryAllEnrollStudentInCourse() async {
    Database db = await DatabaseHelper.db;
    return await db.query('enrollments');
  }

  // Enroll a student in a course (Many-to-Many relationship)
  static Future<int> enrollStudentInCourse(int studentId, int courseId) async {
    Database db = await DatabaseHelper.db;
    return await db.insert('enrollments', {'studentId': studentId, 'courseId': courseId},
      conflictAlgorithm: ConflictAlgorithm.replace, // to avoid duplicates
    );
  }

  // Get all courses a student is enrolled in
  static Future<List<Map<String, dynamic>>> getCoursesForStudent(int studentId) async {
    Database db = await DatabaseHelper.db;
    return await db.rawQuery('''
      SELECT course.id, course.courseName, course.courseCode
      FROM course
      JOIN enrollments ON enrollments.courseId = course.id
      WHERE enrollments.studentId = ?
    ''', [studentId]);
  }

  // Get all students enrolled in a specific course
  static Future<List<Map<String, dynamic>>> getStudentsForCourse(int courseId) async {
    Database db = await DatabaseHelper.db;
    return await db.rawQuery('''
      SELECT student.id, student.name, student.department
      FROM student
      JOIN enrollments ON enrollments.studentId = student.id
      WHERE enrollments.courseId = ?
    ''', [courseId]);
  }

  // Delete enrollment (remove student from course)
  static Future<void> deleteEnrollment(int studentId, int courseId) async {
    Database db = await DatabaseHelper.db;
    await db.delete(
      'enrollments',
      where: 'studentId = ? AND courseId = ?',
      whereArgs: [studentId, courseId],
    );
  }
}