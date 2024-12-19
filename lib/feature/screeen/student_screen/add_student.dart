import 'package:department_management/feature/view_model/student_views_model/student_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddStudent extends ConsumerStatefulWidget {
  const AddStudent({super.key});

  @override
  ConsumerState<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends ConsumerState<AddStudent> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();

  void msgShow(bool ok){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok? 'Information successfully added!' : 'Invalid Input'),
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
                  if (_nameController.text.trim().length == 0 || _departmentController.text.trim().length == 0) msgShow(false);
                  else {
                    await ref.read(studentProvider.notifier).addStudent(
                        name: _nameController.text.trim(),
                        department: _departmentController.text.trim()
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
              controller: _nameController,
              maxLength: 40,
              maxLines: 1,
              decoration: InputDecoration(
                counter: Offstage(),
                border: InputBorder.none,
                hintText: "Name",
                hintStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600
              ),
            ),
            TextField(
              controller: _departmentController,
              maxLines: 1,
              maxLength: 40,
              decoration: InputDecoration(
                counter: Offstage(),
                border: InputBorder.none,
                hintText: "Department",
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
