part of 'home_bloc.dart';

@immutable
class HomeState {
  final List<StudentModel> studentList;

  HomeState({required this.studentList});
}

class HomeInitial extends HomeState {
  HomeInitial({required super.studentList});
}
