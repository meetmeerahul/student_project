// ignore: must_be_immutable
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_project/db/models/student_model.dart';

// ignore: must_be_immutable
class Details extends StatelessWidget {
  final double coverHeight = 200;
  final double profileHeight = 160;
  final double coverWidth = 500;

  Details({
    Key? key,
    required this.passValue,
    required this.passId,
  }) : super(key: key);

  StudentModel passValue;
  final int passId;

  //Widgets Used for displaying student list

  Widget content() {
    return SizedBox(
      width: 200,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            ' ${passValue.name}',
            style: const TextStyle(fontSize: 28),
          ),
          Text('Age : ${passValue.age}',
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
          Text('Number : ${passValue.num}',
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget top() {
    final top = coverHeight - profileHeight / 2.5;
    final bottom = profileHeight / 2;
    return Stack(clipBehavior: Clip.none, children: [
      Container(margin: EdgeInsets.only(bottom: bottom), child: CoverImage()),
      Positioned(
        top: top,
        left: 10,
        child: ProfileImage(),
      ),
    ]);
  }

  // ignore: non_constant_identifier_names
  Widget CoverImage() => Container(
        //color: const Color.fromRGBO(234, 236, 238, 2),

        width: coverWidth - 100,
        height: coverHeight + 50,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
          ),
        ),
      );

  // ignore: non_constant_identifier_names
  Widget ProfileImage() => CircleAvatar(
        backgroundImage: FileImage(File(passValue.image)),
        radius: profileHeight / 3,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          top(),
          content(),
        ],
      ),
    );
  }
}
