import 'package:department_management/feature/view_model/enrollments_view_model/enrollment_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseVsStudent extends ConsumerStatefulWidget {
  const CourseVsStudent({super.key});

  @override
  ConsumerState<CourseVsStudent> createState() => _CourseVsStudentState();
}

class _CourseVsStudentState extends ConsumerState<CourseVsStudent> {
  @override
  void initState() {
    // TODO: implement initState
    ref.read(enrollmentProvider.notifier).initialize();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final home = ref.watch(enrollmentProvider).enroll;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: ListView.builder(
      itemCount: home.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Card(
                  child: ListTile(
                    //tileColor: Colors.lightBlueAccent,
                    title: Text(maxLines: 1, "${home[index].studentId}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                    subtitle: Text(maxLines: 1, "${home[index].courseId}", style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis)),
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
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ReadTodo(title: home.myTodo[index].title, description: home.myTodo[index].description, index: index, id: home.myTodo[index].id)),);
                      print("Tapped on ${index}");
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
