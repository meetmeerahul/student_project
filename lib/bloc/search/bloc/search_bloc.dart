import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:student_project/db/functions/db_functions.dart';
import 'package:student_project/db/models/student_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial(modelList: listStudents)) {
    on<Search>((event, emit) {
      // TODO: implement event handler
      emit(SearchState(
          modelList: event.student
              .where((element) => element.name
                  .toLowerCase()
                  .contains(event.value.toLowerCase()))
              .toList()));
    });
  }
}
