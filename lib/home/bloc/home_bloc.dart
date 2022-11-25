import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_recognition_repository/image_recognition.dart';

part 'home.state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required ImageRecognitionRepository imageRecognitionRepository,
  })  : _imageRecognitionRepository = imageRecognitionRepository,
        super(const HomeState()) {
    on<HomeImageRecognitionSubmitted>(retrieveTextFromImage);
  }

  final ImageRecognitionRepository _imageRecognitionRepository;

  void retrieveTextFromImage(
    HomeImageRecognitionSubmitted event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final text = await _imageRecognitionRepository.getTextFromImage(event.imageB64);
      emit(state.copyWith(status: HomeStatus.success, textFromImage: text));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
