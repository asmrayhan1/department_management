import 'package:department_management/feature/model/student.dart';

class StudentGenerics {
  List<Student> student;
  StudentGenerics({this.student = const []});

  StudentGenerics update({List<Student>? currentStudent}){
    return StudentGenerics(
        student: currentStudent?? this.student
    );
  }
}