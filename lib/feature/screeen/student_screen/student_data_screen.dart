import 'package:department_management/feature/screeen/enrollment_screen/add_student_information.dart';
import 'package:department_management/feature/screeen/student_screen/add_student.dart';
import 'package:department_management/feature/view_model/student_views_model/student_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentDataScreen extends ConsumerStatefulWidget {
  const StudentDataScreen({super.key});

  @override
  ConsumerState<StudentDataScreen> createState() => _StudentDataScreemState();
}

class _StudentDataScreemState extends ConsumerState<StudentDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    ref.read(studentProvider.notifier).initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(studentProvider).student;
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
                        title: Text(maxLines: 1, "${home[index].name}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                        subtitle: Text(maxLines: 1, "${home[index].department}", style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis)),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudentInformation(id: home[index].id!, name: home[index].name, department: home[index].department)),);
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudent()),);
              },
              child: Icon(Icons.add),
            ),
          ),
        ]
    );
  }
}
