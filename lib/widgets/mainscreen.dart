import 'package:flutter/material.dart';
import 'package:student_project/widgets/student_home.dart';
import 'package:student_project/widgets/widget_students_add.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final screens = [
    const ScreenHome(
      title: 'Students List',
    ),
    const StudentAddWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 0),
        child: BottomNavigationBar(
          selectedItemColor: Colors.blue[500],
          unselectedItemColor: Colors.teal,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: 'View Students ',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              label: 'Add Student',
            ),
          ],
        ),
      ),
    );
  }
}
