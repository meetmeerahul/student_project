part of 'update_image_bloc.dart';

@immutable
abstract class UpdateImageEvent {}

// ignore: must_be_immutable
class UpdatedImage extends UpdateImageEvent {
  String? imagePath;
  UpdatedImage({required this.imagePath});
}
