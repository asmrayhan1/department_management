import 'package:department_management/feature/screeen/course_screen/course_data_screen.dart';
import 'package:department_management/feature/screeen/course_vs_student.dart';
import 'package:department_management/feature/screeen/student_screen/student_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Department Management", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),),
        ),
        body: Column(
          children: [
            TabBar(
              indicatorColor: Colors.green,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: <Widget>[
                Text("Student", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: (currentTabIndex == 0? Colors.green : Colors.black)),),
                Text("Course", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: (currentTabIndex == 1? Colors.green : Colors.black)),)
              ],
      
              onTap: (index){
                setState(() {
                  currentTabIndex = index;
                });
              },
            ),
      
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  StudentDataScreen(),
                  CourseDataScreen()
                  //CourseDataScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
