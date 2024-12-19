import 'package:department_management/feature/view_model/course_views_model/course_view_model.dart';
import 'package:department_management/feature/view_model/enrollments_view_model/enrollment_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/course.dart';

class AddStudentInformation extends ConsumerStatefulWidget {
  final int id;
  final String name;
  final String department;

  const AddStudentInformation({super.key, required this.id, required this.name, required this.department});

  @override
  ConsumerState<AddStudentInformation> createState() => _AddStudentState();
}

class _AddStudentState extends ConsumerState<AddStudentInformation> {
  List<String> courseInfo = [];
  Map<String, int> getCourseId = {};

  String? _selectedValue = null;


  // Initialize courses after widget dependencies are set.
  @override
  void didChangeDependencies() async {
    await ref.read(enrollmentProvider.notifier).getCoursesForStudent(studentId: widget.id);
    _initialize();
    super.didChangeDependencies();
  }

  // Fetch and initialize course info and course IDs
  _initialize() {
    final currentCourse = ref.watch(courseProvider).course;
    courseInfo.clear(); // Clear previous courses
    getCourseId.clear(); // Clear previous course mapping

    if (currentCourse != null && currentCourse.isNotEmpty) {
      for (var course in currentCourse) {
        courseInfo.add(course.courseName); // Add course names to list
        getCourseId[course.courseName] = course.id!; // Map course names to their IDs
      }
    } else {
      print("No courses available.");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Course> home = ref.watch(enrollmentProvider).myCourse;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.keyboard_backspace, color: Colors.white, size: 28)
        ),
        title: Center(child: Text("Student Information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(" "),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Center(child: Text("${widget.name}", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),)),
            Center(child: Text("${widget.department}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String> (
                  value: _selectedValue,
                  hint: Text("Select Course", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  items: courseInfo.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                  },
                ),
                SizedBox(width: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // Text color of the button
                    ),

                    onPressed: () async {
                      if (_selectedValue != null) {
                        int courseId = getCourseId[_selectedValue]!;
                        await ref.read(enrollmentProvider.notifier)
                            .intsertStudentInCourse(
                            studentId: widget.id, courseId: courseId);
                        await ref.read(enrollmentProvider.notifier)
                            .getCoursesForStudent(studentId: widget.id);
                      }
                      _selectedValue = null;
                    },
                    child: Text("Add Course")
                )
              ],
            ),
            SizedBox(height: 20),
            // Text(_selectedValue ?? "No option selected"),
            Expanded(
                child: ListView.builder(
                  itemCount: home.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Card(
                            child: ListTile (
                              //tileColor: Colors.lightBlueAccent,
                              title: Text(maxLines: 1, "${home[index].courseName}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                              subtitle: Text(maxLines: 1, "${home[index].courseCode}", style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis)),
                              trailing: GestureDetector(
                                  onTap: () {
                                    // await ref.read(studentProvider.notifier).deleteCategory(categoryId: home[index].categoryId);
                                    // await ref.read(tagProvider.notifier).deleteTag(tagId: home[index].tagId);
                                    // await ref.read(animalProvider.notifier).deleteAnimal(id: home[index].id!);
                                    //print("CategoryId = ${home.myTodo[index].categoryId}");
                                    //_showDialog(home.myTodo[index].id!);
                                    print("Delete Icon is Working");
                                  },
                                  child: Icon(Icons.delete)
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
            )
          ],
        ),
      ),
    );
  }
}
