part of 'update_image_bloc.dart';

class UpdateImageState {
  String? image;

  UpdateImageState(this.image);
}

class UpdateImageInitial extends UpdateImageState {
  UpdateImageInitial() : super('');
}
