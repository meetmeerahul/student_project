import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_project/bloc/home/bloc/home_bloc.dart';

import 'package:student_project/db/models/student_model.dart';

List<StudentModel> listStudents = [];

addStudents(StudentModel student, BuildContext context) {
  //studentListNotifier.value.add(value);

  final studentDB = Hive.box<StudentModel>('student_db');
  BlocProvider.of<HomeBloc>(context).add(AddStudents(list: student));
  studentDB.add(student);
  // getAllStudents();
}

getAllStudents() {
  final studentDB = Hive.box<StudentModel>('student_db');
  listStudents.clear();
  listStudents.addAll(studentDB.values);
}

deleteStudent(int id, BuildContext context) async {
  final studentDB = await Hive.box<StudentModel>('student_db');
  // ignore: use_build_context_synchronously
  BlocProvider.of<HomeBloc>(context).add(DeleteStudents(stdId: id));
  await studentDB.deleteAt(id);
  getAllStudents();
}
