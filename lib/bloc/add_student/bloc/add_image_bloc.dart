import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_image_event.dart';
part 'add_image_state.dart';

class AddImageBloc extends Bloc<AddImageEvent, AddImageState> {
  AddImageBloc() : super(AddImageInitial()) {
    on<AddImage>(
      (event, emit) {
        // TODO: implement event handler
        return emit(AddImageState(image: event.imagepath!));
      },
    );
  }
}
