import 'package:hive_flutter/hive_flutter.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String num;

  @HiveField(4)
  final String image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.num,
      required this.image,
      this.id});
}
