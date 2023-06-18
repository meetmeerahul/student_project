import 'package:flutter/material.dart';
import 'package:student_project/db/functions/db_functions.dart';
import 'package:student_project/screens/view_student.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return const Scaffold(
      body: ListStudents(),
    );
  }
}
