import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_project/bloc/home/bloc/home_bloc.dart';

import 'package:student_project/db/functions/db_functions.dart';
import 'package:student_project/db/models/student_model.dart';
import 'package:student_project/screens/add_student.dart';
import 'package:student_project/screens/search_student.dart';
import 'package:student_project/screens/student_details.dart';
import 'package:student_project/screens/update_student.dart';

class ListStudents extends StatelessWidget {
  const ListStudents({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    getAllStudents();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Student List'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchStudent()));
                  },
                  icon: const Icon(Icons.search)),
            ],
          ),
          body: ListView.separated(
            itemBuilder: (ctx, index) {
              var data = state.studentList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    // backgroundColor: Colors.green,
                    backgroundImage: FileImage(File(data.image)),
                  ),
                  title: Text(data.name),
                  trailing: Wrap(
                    spacing: 12,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateStudent(
                                    index: index, passValue: data),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          color: Colors.blue),
                      IconButton(
                        onPressed: () {
                          deleteAlert(
                              context: context, data: data, index: index);
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => Details(
                          passId: index,
                          passValue: data,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: state.studentList.length,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddStudent()));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  deleteAlert({required context, required index, required StudentModel data}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text('Delete ${data.name} ?'),
        actions: [
          TextButton(
              onPressed: () {
                deleteStudent(index, context);
                Navigator.of(context).pop(ctx);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(ctx);
              },
              child: const Text('Cancel'))
        ],
      ),
    );
  }
}
