import 'package:image_recognition_repository/image_recognition.dart';

import '../http/http.dart';

ImageRecognitionRepository makeImageRecognitionRespositoryFactory() =>
    ImageRecognitionRepository(httpClient: makeHttpAdapterFactory(), url: makeApiUrl('image-recognition'));
