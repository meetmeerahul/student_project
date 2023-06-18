part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class AddStudents extends HomeEvent {
  final StudentModel list;

  AddStudents({required this.list});
}

class DeleteStudents extends HomeEvent {
  final int stdId;

  DeleteStudents({required this.stdId});
}

class UpdateStudents extends HomeEvent {
  final int stdId;
  final StudentModel newList;

  UpdateStudents({required this.stdId, required this.newList});
}
