import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/material.dart';
import 'package:student_project/db/models/student_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDataB = await Hive.openBox<StudentModel>('student_db1');
  final id = await studentDataB.add(value);
  value.id = id;

  getAllStudents();

  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDataB = await Hive.openBox<StudentModel>('student_db1');

  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDataB.values);
  studentListNotifier.notifyListeners();
}

//Deliting Student
Future<void> deleteStudent(int id) async {
  final studentDataB = await Hive.openBox<StudentModel>('student_db1');
  log(id.toString());
  studentDataB.deleteAt(id);
  getAllStudents();
}

//Updating Student
Future<void> updateNew(StudentModel value, int id) async {
  final studentDataB = await Hive.openBox<StudentModel>('student_db1');

  studentDataB.putAt(id, value);
  studentListNotifier.value.clear();
  return;
}
