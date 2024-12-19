import 'package:department_management/feature/model/enrollment.dart';
import 'package:department_management/feature/model/student.dart';
import 'package:department_management/feature/view_model/enrollments_view_model/enrollment_generics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/course.dart';

final enrollmentProvider = StateNotifierProvider<EnrollmentController, EnrollmentGenerics> ((ref) => EnrollmentController());

class EnrollmentController extends StateNotifier<EnrollmentGenerics> {
  EnrollmentController() : super(EnrollmentGenerics());

  initialize() async {
    final dataFetch = await EnrollmentTableProvider.queryAllEnrollStudentInCourse();
    List<Enrollment> tmp = dataFetch.map((tmp) => Enrollment.fromMap(tmp)).toList();
    state = state.update(currentData: tmp);
  }

  intsertStudentInCourse({required int studentId, required int courseId}) async {
    await EnrollmentTableProvider.enrollStudentInCourse(studentId, courseId);
    //List<TodoModel> todos1 = [...state.todos, newTodoModel];
    initialize();
  }

  getCoursesForStudent({required int studentId}) async {
    final getData = await EnrollmentTableProvider.getCoursesForStudent(studentId);
    List<Course> tmp = getData.map((tmp) => Course.fromMap(tmp)).toList();
    state = state.update(currentCourse: tmp);
  }

  getStudentsForCourse({required int courseId}) async {
    final getData = await EnrollmentTableProvider.getStudentsForCourse(courseId);
    List<Student> tmp = getData.map((tmp) => Student.fromMap(tmp)).toList();
    state = state.update(currentStudent: tmp);
  }

  deleteEnrollment({required int studentId, required int courseId}) async {
    await EnrollmentTableProvider.deleteEnrollment(studentId, courseId);
  }
}