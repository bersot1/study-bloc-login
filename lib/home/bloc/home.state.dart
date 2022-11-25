part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.textFromImage = '',
    this.status = HomeStatus.initial,
  });

  final String textFromImage;
  final HomeStatus status;

  HomeState copyWith({
    String? textFromImage,
    HomeStatus? status,
  }) {
    return HomeState(
      textFromImage: textFromImage ?? this.textFromImage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [textFromImage, status];
}
