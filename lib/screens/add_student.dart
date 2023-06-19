// ignore: must_be_immutable
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:student_project/bloc/add_student/bloc/add_image_bloc.dart';
import 'package:student_project/db/functions/db_functions.dart';
import 'package:student_project/db/models/student_model.dart';

// ignore: must_be_immutable
class AddStudent extends StatelessWidget {
  AddStudent({super.key});

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _phnNoController = TextEditingController();
  // final context = BuildContext;

  String? imagepath;

  @override
  Widget build(BuildContext context) {
    context.read<AddImageBloc>().add(AddImage(imagepath: ''));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              // BlocBuilder<AddImageBloc, AddImageState>(
              //   builder: (context, state) {
              //  imagepath = state.image;
              // return
              Stack(children: [
                BlocBuilder<AddImageBloc, AddImageState>(
                  builder: (context, state) {
                    imagepath = state.image;
                    return CircleAvatar(
                      backgroundImage: state.image.isEmpty
                          ? const AssetImage('assets/1.jpg') as ImageProvider
                          : FileImage(File(imagepath!)),
                      radius: 75,
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
              ]),

              // ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.orange),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'Age'),
                  maxLength: 2,
                  buildCounter: (BuildContext context,
                          {required int currentLength,
                          int? maxLength,
                          bool? isFocused}) =>
                      null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _phnNoController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.orange),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: 'Mobile'),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  buildCounter: (BuildContext context,
                          {required int currentLength,
                          int? maxLength,
                          bool? isFocused}) =>
                      null,
                ),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    addStudentButtonClicked(context);
                  },
                  icon: const Icon(Icons.upload),
                  label: const Text('Add'))
            ],
          ),
        ),
      ),
    );
  }

  addStudentButtonClicked(BuildContext context) async {
//print('$_name $_age');final _name = _nameController.text.trim();
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _mobile = _phnNoController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _mobile.isEmpty) {
      showSnackBar(context);
    } else {
      final _student =
          StudentModel(name: _name, age: _age, num: _mobile, image: imagepath!);
      addStudents(_student, context);
      Navigator.of(context).pop();
      studentAddSnackBar(context);
    }
  }

  takePhoto(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // imagepath = pickedFile.path;
      BlocProvider.of<AddImageBloc>(context)
          .add(AddImage(imagepath: pickedFile.path));
    }
  }

  showSnackBar(BuildContext context) {
    var _errMsg = "";

    if (imagepath == null &&
        _nameController.text.isEmpty &&
        _ageController.text.isEmpty &&
        _phnNoController.text.isEmpty) {
      _errMsg = "Please Insert Valid Data In All Fields ";
    } else if (imagepath == null) {
      _errMsg = "Please Select An Image to Continue";
    } else if (_nameController.text.isEmpty) {
      _errMsg = "Name  Must Be Filled";
    } else if (_ageController.text.isEmpty) {
      _errMsg = "Age  Must Be Filled";
    } else if (_phnNoController.text.isEmpty) {
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

  void studentAddSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromRGBO(119, 153, 174, 1),
        content: Text('Student is succesfully added!'),
      ),
    );
  }
}
