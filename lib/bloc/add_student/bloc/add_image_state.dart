part of 'add_image_bloc.dart';

@immutable
class AddImageState {
  final String image;

  const AddImageState({required this.image});
}

class AddImageInitial extends AddImageState {
  const AddImageInitial() : super(image: '');
}
