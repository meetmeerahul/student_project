import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_image_event.dart';
part 'update_image_state.dart';

class UpdateImageBloc extends Bloc<UpdateImageEvent, UpdateImageState> {
  UpdateImageBloc() : super(UpdateImageInitial()) {
    on<UpdatedImage>((event, emit) {
      // TODO: implement event handler
      return emit(UpdateImageState(event.imagePath));
    });
  }
}
