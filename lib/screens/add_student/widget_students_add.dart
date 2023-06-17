import 'dart:io';

import 'package:flutter/material.dart';

import 'package:student_project/db/models/student_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_project/widgets/mainscreen.dart';

import '../../db/functions/db_functions.dart';

class StudentAddWidget extends StatefulWidget {
  const StudentAddWidget({super.key});

  @override
  State<StudentAddWidget> createState() => _StudentAddWidgetState();
}

class _StudentAddWidgetState extends State<StudentAddWidget> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _numController = TextEditingController();

  String? imagepath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Add Student'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_sharp),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => const MainScreen()),
              (route) => false),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(children: [
                  CircleAvatar(
                    backgroundImage: imagepath == null
                        ? const AssetImage('assets/1.jpg') as ImageProvider
                        : FileImage(File(imagepath!)),
                    radius: 50,
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      width: 30,
                      child: InkWell(
                          child: const Icon(
                            Icons.add_a_photo_sharp,
                            size: 30,
                            color: Colors.teal,
                          ),
                          onTap: () {
                            takePhoto();
                          })),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.abc_sharp,
                      color: Colors.teal,
                    ),
                    filled: true,
                    fillColor: const Color.fromRGBO(234, 236, 238, 2),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Name',
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _ageController,
                  buildCounter: (BuildContext context,
                          {required int currentLength,
                          int? maxLength,
                          bool? isFocused}) =>
                      null,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.numbers_sharp,
                      color: Colors.teal,
                    ),
                    filled: true,
                    fillColor: const Color.fromRGBO(234, 236, 238, 2),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Age',
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _numController,
                  buildCounter: (BuildContext context,
                          {required int currentLength,
                          int? maxLength,
                          bool? isFocused}) =>
                      null,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.phone_android,
                      color: Colors.teal,
                    ),
                    filled: true,
                    fillColor: const Color.fromRGBO(234, 236, 238, 2),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (imagepath != null &&
                      _nameController.text.isNotEmpty &&
                      _ageController.text.isNotEmpty &&
                      _numController.text.isNotEmpty) {
                    studentAddSnackBar();

                    onAddStudentButtonClicked(context);

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) => const MainScreen()),
                        (route) => false);
                  } else {
                    showSnackBar();
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Student'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _num = _numController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _num.isEmpty) {
      return;
    }

    final _student = StudentModel(
      name: _name,
      age: _age,
      num: _num,
      image: imagepath!,
    );

    addStudent(_student);
  }

  Future<void> takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagepath = pickedFile.path;
      });
    }
  }

  showSnackBar() {
    var _errMsg = "";

    if (imagepath == null &&
        _nameController.text.isEmpty &&
        _ageController.text.isEmpty &&
        _numController.text.isEmpty) {
      _errMsg = "Please Insert Valid Data In All Fields ";
    } else if (imagepath == null) {
      _errMsg = "Please Select An Image to Continue";
    } else if (_nameController.text.isEmpty) {
      _errMsg = "Name  Must Be Filled";
    } else if (_ageController.text.isEmpty) {
      _errMsg = "Age  Must Be Filled";
    } else if (_numController.text.isEmpty) {
      _errMsg = "Phone Number Must Be Filled";
      return;
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

  void studentAddSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.teal,
        content: Text('This Student Inserted Into Database'),
      ),
    );
  }
}
