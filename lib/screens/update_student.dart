import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_project/bloc/add_student/bloc/add_image_bloc.dart';
import 'package:student_project/bloc/update_image/bloc/update_image_bloc.dart';
import 'package:student_project/db/functions/db_functions.dart';
import 'package:student_project/db/models/student_model.dart';
import 'package:student_project/screens/view_student.dart';

String tempimg = "";

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
        // image: imagePath ?? widget.passValue.image,
        image: tempimg);

    final studentDB = await Hive.openBox<StudentModel>('Student_db');
    studentDB.putAt(index, _students);

    getAllStudents();
  }

  Widget elavatedbtn() {
    return ElevatedButton.icon(
      onPressed: () {
        final _name = _nameController.text.trim();
        final _age = _ageController.text.trim();
        final _mobile = _numController.text.trim();

        if (_name.isEmpty || _age.isEmpty || _mobile.isEmpty) {
          showSnackBar(context);
        } else {
          StudentAddBtn(widget.index);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => const ListStudents()),
              (route) => false);
        }
      },
      icon: const Icon(Icons.update_rounded),
      label: const Text('Update'),
    );
  }

  Widget textFieldName({
    required TextEditingController myController,
  }) {
    if (myController == _ageController) {
      return TextFormField(
        autofocus: false,
        controller: myController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        maxLength: 2,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Colors.orange),
            borderRadius: BorderRadius.circular(5.0),
          ),
          // hintText: hintName,
          // counterText: myController.text
        ),
        // initialValue: 'hintName',
      );
    } else if (myController == _numController) {
      return TextFormField(
        autofocus: false,
        keyboardType: TextInputType.number,
        controller: myController,
        cursorColor: Colors.black,
        maxLength: 10,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Colors.orange),
            borderRadius: BorderRadius.circular(5.0),
          ),
          // hintText: hintName,
          // counterText: myController.text
        ),
        // initialValue: 'hintName',
      );
    } else {
      return TextFormField(
        autofocus: false,

        controller: myController,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Colors.orange),
            borderRadius: BorderRadius.circular(5.0),
          ),
          // hintText: hintName,
          // counterText: myController.text
        ),
        // initialValue: 'hintName',
      );
    }
  }

  Widget dpImage() {
    return Stack(
      children: [
        BlocBuilder<UpdateImageBloc, UpdateImageState>(
          builder: (context, state) {
            // tempimg =
            //     (tempimg != widget.passValue.image ? state.image : tempimg)!;
            return CircleAvatar(
              radius: 75,
              backgroundImage: FileImage(File(state.image!)),
              // backgroundImage: imagePath == null
              //     ? FileImage(File(widget.passValue.image))
              //     : FileImage(File(imagePath!)),
            );
          },
        ),
        Positioned(
          bottom: 0,
          right: 0,
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
    context
        .read<UpdateImageBloc>()
        .add(UpdatedImage(imagePath: widget.passValue.image));
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
      tempimg = PickedFile.path;
      BlocProvider.of<UpdateImageBloc>(context)
          .add(UpdatedImage(imagePath: tempimg));
    }
  }

  showSnackBar(BuildContext context) {
    var _errMsg = "";

    if (_nameController.text.isEmpty &&
        _ageController.text.isEmpty &&
        _numController.text.isEmpty) {
      _errMsg = "Please Insert Valid Data In All Fields ";
    } else if (_nameController.text.isEmpty) {
      _errMsg = "Name  Must Be Filled";
    } else if (_ageController.text.isEmpty) {
      _errMsg = "Age  Must Be Filled";
    } else if (_numController.text.isEmpty) {
      _errMsg = "Phone Number Must Be Filled";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10.0),
        content: Text(_errMsg),
      ),
    );
  }
}
