import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_project/bloc/search/bloc/search_bloc.dart';
import 'package:student_project/db/functions/db_functions.dart';
import 'package:student_project/db/models/student_model.dart';
import 'package:student_project/screens/student_details.dart';

// ignore: must_be_immutable
class SearchStudent extends StatelessWidget {
  SearchStudent({super.key});

  final _searchController = TextEditingController();

  List<StudentModel> studentList =
      Hive.box<StudentModel>('student_db').values.toList();

  late List<StudentModel> studentDisplay = List<StudentModel>.from(studentList);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchBloc>(context)
        .add(Search(value: '', student: listStudents));
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: _searchController,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => clearText(),
                  ),
                  filled: true,
                  fillColor: const Color.fromRGBO(234, 236, 238, 2),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)),
                ),
                onChanged: (value) {
                  BlocProvider.of<SearchBloc>(context)
                      .add(Search(value: value, student: listStudents));
                },
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return Expanded(
                      child: ListView.builder(
                    itemCount: state.modelList.length,
                    itemBuilder: (context, index) {
                      // final data = studentList[index];
                      File img = File(state.modelList[index].image);
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(img),
                        ),
                        title: Text(state.modelList[index].name),
                        onTap: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(
                                passValue: state.modelList[index],
                                passId: index,
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  )
                      // : const Center(
                      //     child: Text(
                      //       'No match found',
                      //       style: TextStyle(fontSize: 20),
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   ),
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void clearText() {
    _searchController.clear();
  }
}
