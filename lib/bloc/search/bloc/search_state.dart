part of 'search_bloc.dart';

@immutable
class SearchState {
  final List<StudentModel> modelList;

  SearchState({required this.modelList});
}

class SearchInitial extends SearchState {
  SearchInitial({required super.modelList});
}
