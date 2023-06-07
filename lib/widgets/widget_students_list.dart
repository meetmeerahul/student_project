import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_project/db/functions/db_functions.dart';
import 'package:student_project/db/models/student_model.dart';
import 'package:student_project/widgets/search_widget.dart';
import 'package:student_project/widgets/update_student.dart';
import 'package:student_project/widgets/widget_students_add.dart';
import 'package:student_project/widgets/widget_view_student.dart';

class ListStudentWidget extends StatefulWidget {
  const ListStudentWidget({super.key});

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  late Box<StudentModel> studentBox;

  final screens = [const ListStudentWidget(), const StudentAddWidget()];

  @override
  void initState() {
    super.initState();

    studentBox = Hive.box('student_db1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Student List'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => SearchScreen(),
                ));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: ValueListenableBuilder(
            valueListenable: studentListNotifier,
            builder: (BuildContext ctx, List<StudentModel> studentList,
                Widget? child) {
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = studentList[index];

                  return ListTile(
                    title: Text(data.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => StudentView(
                            passId: index,
                            passValue: data,
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(data.image)),
                      radius: 30,
                    ),
                    trailing: FittedBox(
                      fit: BoxFit.fill,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UpdateStudent(index: index),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.teal,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                deleteStudentAlert(context, index);
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: studentList.length,
              );
            },
          ),
        ),
      ),
    );
    //    floatingActionButton: FloatingActionButton(
    //      onPressed: () {
    //        Navigator.of(context).push(
    //          MaterialPageRoute(
    //            builder: (context) => const StudentAddWidget(),
    //          ),
    //        );
    //      },
    //      child: const Icon(Icons.add),
    //    ),
    //    bottomNavigationBar: bottomNavBarDisplay(),
    // );
  }

  deleteStudentAlert(BuildContext context, index) {
    showDialog(
      context: context,
      builder: ((ctx) => AlertDialog(
            content: const Text('really want to delete '),
            actions: [
              TextButton(
                onPressed: () {
                  deleteStudent(index);
                  Navigator.of(context).pop(ctx);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(ctx),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          )),
    );
  }

  // BottomNavigationBar bottomNavBarDisplay() {
  //   return BottomNavigationBar(
  //     items: const <BottomNavigationBarItem>[
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.list),
  //         label: 'View Students',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.add),
  //         label: 'Add Student',
  //       ),
  //     ],
  //   );
  // }
}
