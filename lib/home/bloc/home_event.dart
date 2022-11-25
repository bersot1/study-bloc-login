part of './home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  List<Object> get props => [];
}

class HomeImageRecognitionSubmitted extends HomeEvent {
  HomeImageRecognitionSubmitted(this.imageB64);

  final String imageB64;
}

// class HomeImageRecognitionInProgress extends HomeEvent {}

// class HomeImageRecognitionLoadSuccess extends HomeEvent {
//   const HomeImageRecognitionLoadSuccess(this.imageB64);

//   final String imageB64;

//   @override
//   List<Object> get props => [imageB64];
// }
