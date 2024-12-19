import 'package:department_management/feature/model/enrollment.dart';

import '../../model/course.dart';
import '../../model/student.dart';

class EnrollmentGenerics {
  List<Enrollment> enroll;
  List<Course> myCourse;
  List<Student> allStudents;
  EnrollmentGenerics({this.enroll = const [], this.myCourse = const [], this.allStudents = const []});

  EnrollmentGenerics update({List<Enrollment>? currentData, List<Student>? currentStudent, List<Course>? currentCourse}){
    return EnrollmentGenerics(
        enroll: currentData?? this.enroll,
        myCourse: currentCourse?? this.myCourse,
        allStudents: currentStudent?? this.allStudents
    );
  }
}