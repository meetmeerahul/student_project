part of 'add_image_bloc.dart';

// @immutable
// class AddImageState {
//   final String? image;

//   AddImageState({required this.image});
// }

// class AddImageInitial extends AddImageState {
//   AddImageInitial() : super(image: null);
// }


@immutable
class AddImageState {
  final String image;

  AddImageState({required this.image});
}

class AddImageInitial extends AddImageState {
  AddImageInitial() : super(image: '');
}
