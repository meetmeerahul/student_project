import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_project/db/functions/db_functions.dart';

import 'package:student_project/db/models/student_model.dart';
import 'package:student_project/widgets/mainscreen.dart';
import 'package:student_project/widgets/widget_students_list.dart';

class UpdateStudent extends StatefulWidget {
  final int index;

  const UpdateStudent({super.key, required this.index});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _numberController;

  int id = 0;
  String? name;
  int age = 0;
  String? imagepath;

  late Box<StudentModel> studenBox;
  late StudentModel student;

  @override
  void initState() {
    super.initState();

    studenBox = Hive.box('student_db1');

    _idController = TextEditingController();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _numberController = TextEditingController();

    student = studenBox.getAt(widget.index) as StudentModel;

    _idController.text = student.id.toString();
    _nameController.text = student.name.toString();
    _ageController.text = student.age.toString();
    _numberController.text = student.num.toString();
  }

  Future<void> StudentAddBtn(int index) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _number = _numberController.text.trim();
    // final _image = imagePath;

    if (_name.isEmpty || _age.isEmpty || _number.isEmpty) {
      return;
    }
  
    final _students = StudentModel(
      name: _name,
      age: _age,
      num: _number,
      image: imagepath ?? student.image,
    );
    final studentDataB = await Hive.openBox<StudentModel>('student_db1');
    studentDataB.putAt(index, _students);
    getAllStudents();
  }

  Future<void> takePhoto() async {
    // ignore: non_constant_identifier_names
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagepath = PickedFile.path;
      });
    }
  }

  Widget elavatedbtn() {
    return ElevatedButton.icon(
      onPressed: () {
        StudentAddBtn(widget.index);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const ListStudentWidget()),
            (route) => false);
      },
      icon: const Icon(Icons.update_rounded),
      label: const Text('Update'),
    );
  }

  Widget textFieldName({
    required TextEditingController myController,
    required String hintName,
  }) {
    return TextFormField(
      autofocus: false,
      controller: myController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.abc_sharp,
          color: Colors.teal,
        ),
        filled: true,
        fillColor: const Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintName,
      ),
    );
  }

  Widget textFieldNum({
    required TextEditingController myController,
    required String hintName,
  }) {
    return TextFormField(
      autofocus: false,
      controller: myController,
      buildCounter: (BuildContext context,
              {required int currentLength, int? maxLength, bool? isFocused}) =>
          null,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
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
        hintText: hintName,
      ),
      keyboardType: TextInputType.number,
      maxLength: 2,
    );
  }

  Widget textFieldPhoneNum({
    required TextEditingController myController,
    required String hintName,
  }) {
    return TextFormField(
      autofocus: false,
      controller: myController,
      buildCounter: (BuildContext context,
              {required int currentLength, int? maxLength, bool? isFocused}) =>
          null,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.phone_android,
          color: Colors.teal,
        ),
        filled: true,
        fillColor: const Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintName,
      ),
      keyboardType: TextInputType.number,
      maxLength: 10,
    );
  }

  Widget dpImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: imagepath == null
              ? FileImage(File(student.image))
              : FileImage(File(imagepath ?? student.image)),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
              child: const Icon(
                Icons.add_a_photo_sharp,
                size: 30,
                color: Colors.teal,
              ),
              onTap: () {
                takePhoto();
              }),
        ),
      ],
    );
  }

  Widget szdBox = const SizedBox(height: 20);

  Future<void> keyBoard(keyboard) async {
    keyboardType:
    TextInputType.number;
  }

  Widget build(BuildContext context) {
    final student = studenBox.getAt(widget.index) as StudentModel;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_sharp),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => const MainScreen()),
              (route) => false),
        ),
        title: const Text('Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            dpImage(),
            szdBox,
            textFieldName(
              myController: _nameController,
              hintName: student.name,
            ),
            szdBox,
            textFieldNum(myController: _ageController, hintName: student.age),
            szdBox,
            textFieldPhoneNum(
                myController: _numberController, hintName: student.num),
            szdBox,
            elavatedbtn(),
          ]),
        ),
      ),
    );
  }
}
