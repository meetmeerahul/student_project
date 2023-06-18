import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_project/bloc/update_image/bloc/update_image_bloc.dart';
import 'package:student_project/db/functions/db_functions.dart';
import 'package:student_project/db/models/student_model.dart';
import 'package:student_project/screens/view_student.dart';

String tempimg = '';

// ignore: must_be_immutable
class UpdateStudent extends StatefulWidget {
  UpdateStudent({Key? key, required this.index, required this.passValue})
      : super(key: key);

  StudentModel passValue;
  int index;

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  late final _nameController =
      TextEditingController(text: widget.passValue.name);

  late final _ageController = TextEditingController(text: widget.passValue.age);

  late final _numController = TextEditingController(text: widget.passValue.num);

  String? imagePath;

  Future<void> StudentAddBtn(int index) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final number = _numController.text.trim();
    final _students = StudentModel(
      name: name,
      age: age,
      num: number,
      image: imagePath ?? widget.passValue.image,
    );
    final studentDB = await Hive.openBox<StudentModel>('Student_db');
    studentDB.putAt(index, _students);
    getAllStudents();
  }

  Widget elavatedbtn() {
    return ElevatedButton.icon(
      onPressed: () {
        StudentAddBtn(widget.index);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const ListStudents()),
            (route) => false);
      },
      icon: Icon(Icons.update_rounded),
      label: Text('Update'),
    );
  }

  Widget textFieldName({
    required TextEditingController myController,
  }) {
    return TextFormField(
      autofocus: false,
      controller: myController,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        // hintText: hintName,
        // counterText: myController.text
      ),
      // initialValue: 'hintName',
    );
  }

  Widget dpImage() {
    return Stack(
      children: [
        BlocBuilder<UpdateImageBloc, UpdateImageState>(
          builder: (context, state) {
            tempimg =
                (tempimg != widget.passValue.image ? state.image : tempimg)!;
            return CircleAvatar(
              radius: 75,
              backgroundImage: imagePath == null
                  ? FileImage(File(widget.passValue.image))
                  : FileImage(File(imagePath!)),
            );
          },
        ),
        Positioned(
          bottom: 2,
          right: 10,
          child: InkWell(
            child: const Icon(
              Icons.add_a_photo_rounded,
              size: 30,
            ),
            onTap: () {
              takePhoto(context);
            },
          ),
        ),
      ],
    );
  }

  Widget szdBox = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              dpImage(),
              szdBox,
              textFieldName(myController: _nameController),
              szdBox,
              textFieldName(myController: _ageController),
              szdBox,
              textFieldName(myController: _numController),
              szdBox,
              elavatedbtn(),
            ]),
          ),
        ));
  }

  takePhoto(BuildContext context) async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      var tempimg = PickedFile.path;
      BlocProvider.of<UpdateImageBloc>(context)
          .add(UpdatedImage(imagePath: tempimg));
    }
  }
}
