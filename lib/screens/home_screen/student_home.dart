import 'package:flutter/material.dart';

import 'package:student_project/db/functions/db_functions.dart';
import 'package:student_project/widgets/widget_students_list.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return const Scaffold(
      body: ListStudentWidget(),
    );
  }
}
