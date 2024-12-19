import 'package:department_management/feature/view_model/enrollments_view_model/enrollment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseTakenByStudent extends ConsumerStatefulWidget {
  final int courseId;
  final String courseName;
  final String courseCode;
  const CourseTakenByStudent({super.key, required this.courseId, required this.courseName, required this.courseCode});

  @override
  ConsumerState<CourseTakenByStudent> createState() => _CourseTakenByStudentState();
}

class _CourseTakenByStudentState extends ConsumerState<CourseTakenByStudent> {
  @override
  void initState() {
    // TODO: implement initState
    ref.read(enrollmentProvider.notifier).getStudentsForCourse(courseId: widget.courseId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final home = ref.watch(enrollmentProvider).allStudents;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: Text("${widget.courseName}  ${widget.courseCode}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25, color: Colors.white),)),
        actions: [
          Text("    "),
          Text("    "),
        ],
      ),
      body: ListView.builder(
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
