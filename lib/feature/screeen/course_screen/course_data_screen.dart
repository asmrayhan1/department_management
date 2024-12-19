import 'package:department_management/feature/screeen/enrollment_screen/course_taken_by_student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/course_views_model/course_view_model.dart';
import 'add_course.dart';

class CourseDataScreen extends ConsumerStatefulWidget {
  const CourseDataScreen({super.key});

  @override
  ConsumerState<CourseDataScreen> createState() => _StudentDataScreemState();
}

class _StudentDataScreemState extends ConsumerState<CourseDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    ref.read(courseProvider.notifier).initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(courseProvider).course;
    return Stack(
        children: [
          ListView.builder(
            itemCount: home.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Card(
                      child: ListTile(
                        //tileColor: Colors.lightBlueAccent,
                        title: Text(maxLines: 1, "${home[index].courseName}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                        subtitle: Text(maxLines: 1, "${home[index].courseCode}", style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis)),
                        trailing: GestureDetector(
                            onTap: () async {
                              // await ref.read(studentProvider.notifier).deleteCategory(categoryId: home[index].categoryId);
                              // await ref.read(tagProvider.notifier).deleteTag(tagId: home[index].tagId);
                              // await ref.read(animalProvider.notifier).deleteAnimal(id: home[index].id!);
                              //print("CategoryId = ${home.myTodo[index].categoryId}");
                              //_showDialog(home.myTodo[index].id!);
                              print("Delete Icon is Working");
                            },
                            child: Icon(Icons.delete)
                        ),
                        onTap: () {
                          //print("All Todo Id = ${ref.watch(homeProvider).myTodo[index].id}");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CourseTakenByStudent(courseId: home[index].id!, courseName: home[index].courseName, courseCode: home[index].courseCode,)),);
                          print("Tapped on ${index}");
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 10,
            right: 18,
            child: FloatingActionButton(
              onPressed: () {
                print("Add Working");
                // Navigate to the "Add New Item" screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddCourse()),);
              },
              child: Icon(Icons.add),
            ),
          ),
        ]
    );
  }
}
