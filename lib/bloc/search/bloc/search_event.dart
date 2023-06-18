part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

// ignore: must_be_immutable
class Search extends SearchEvent {
  List<StudentModel> student;
  final String value;
  Search({required this.value, required this.student});
}
