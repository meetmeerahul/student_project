part of 'add_image_bloc.dart';

@immutable
class AddImageEvent {}

// ignore: must_be_immutable
class AddImage extends AddImageEvent {
  String? imagepath;
  AddImage({required this.imagepath});
}
