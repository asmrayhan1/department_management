import 'package:department_management/feature/model/student.dart';
import 'package:department_management/feature/view_model/student_views_model/student_view_generics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final studentProvider = StateNotifierProvider<StudentController, StudentGenerics> ((ref) => StudentController());

class StudentController extends StateNotifier<StudentGenerics> {
  StudentController() : super(StudentGenerics());

  initialize() async{
    final dataFetch = await StudentTableProvider.queryAllStudents();
    List<Student> std = dataFetch.map((tmp) => Student.fromMap(tmp)).toList();
    state = state.update(currentStudent: std);
  }

  addStudent({required String name, required String department}) async{
    Student newStudent = Student(name: name, department: department);
    await StudentTableProvider.insertStudent(newStudent);
    //List<TodoModel> todos1 = [...state.todos, newTodoModel];
    initialize();
  }

  deleteStudent({required int id}) async{
    await StudentTableProvider.deleteStudent(id);
    initialize();
  }

  updateStudent({required int id, required String name, required String department}) async{
    Student currentStudent = Student(id: id, name: name, department: department);
    await StudentTableProvider.updateStudent(currentStudent);
  }
}