import 'package:department_management/feature/model/course.dart';
import 'package:department_management/feature/view_model/course_views_model/course_view_generics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final courseProvider = StateNotifierProvider<CourseController, CourseGenerics> ((ref) => CourseController());

class CourseController extends StateNotifier<CourseGenerics> {
  CourseController() : super(CourseGenerics());

  initialize() async{
    final dataFetch = await CourseTableProvider.queryAllCourse();
    List<Course> course1 = dataFetch.map((tmp) => Course.fromMap(tmp)).toList();
    state = state.update(currentCourse: course1);
  }

  addCourse({required String courseName, courseCode}) async{
    Course newCourse = Course(courseName: courseName, courseCode: courseCode);
    await CourseTableProvider.insertCourse(newCourse);
    //List<TodoModel> todos1 = [...state.todos, newTodoModel];
    initialize();
  }

  deleteCourse({required int id}) async{
    await CourseTableProvider.deleteCourse(id);
    initialize();
  }

  updateCourse({required int id, required String courseName, required String courseCode}) async{
    Course currentCourse = Course(id: id, courseName: courseName, courseCode: courseCode);
    await CourseTableProvider.updateCourse(currentCourse);
  }
}