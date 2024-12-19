import 'package:department_management/feature/view_model/course_views_model/course_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddCourse extends ConsumerStatefulWidget {
  const AddCourse({super.key});

  @override
  ConsumerState<AddCourse> createState() => _AddStudentState();
}

class _AddStudentState extends ConsumerState<AddCourse> {
  TextEditingController _courseNameController = TextEditingController();
  TextEditingController _courseCodeController = TextEditingController();

  void msgShow(bool ok){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok? 'Course successfully added!' : 'Invalid Input'),
        duration: Duration(seconds: 4),
        // Duration the snackbar is shown
        backgroundColor: Colors.green, // Background color of the SnackBar
        //behavior: SnackBarBehavior.floating,
        //margin: EdgeInsets.only(bottom: 100),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            child: GestureDetector(
                onTap: () async {
                  if (_courseNameController.text.trim().length == 0 || _courseCodeController.text.trim().length == 0) msgShow(false);
                  else {
                    await ref.read(courseProvider.notifier).addCourse(
                      courseName: _courseNameController.text.trim(),
                      courseCode: _courseCodeController.text.trim()
                    );
                    Navigator.of(context).pop();
                    msgShow(true);
                  }
                },
                child: Icon(Icons.save, color: Colors.white, size: 28)
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: _courseNameController,
              maxLength: 40,
              maxLines: 1,
              decoration: InputDecoration(
                counter: Offstage(),
                border: InputBorder.none,
                hintText: "Course Name",
                hintStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600
              ),
            ),
            TextField(
              controller: _courseCodeController,
              maxLines: 1,
              maxLength: 40,
              decoration: InputDecoration(
                counter: Offstage(),
                border: InputBorder.none,
                hintText: "Course Code",
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              style: TextStyle (
                  fontSize: 20
              ),
            ),
          ],
        ),
      ),
    );
  }
}
