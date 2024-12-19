import '../../model/course.dart';

class CourseGenerics{
  List<Course> course;
  CourseGenerics({this.course = const []});

  CourseGenerics update({List<Course>? currentCourse}){
    return CourseGenerics(
        course: currentCourse?? this.course
    );
  }
}