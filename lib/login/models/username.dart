import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class UsernameModel extends FormzInput<String, UsernameValidationError> {
  const UsernameModel.pure() : super.pure('');
  const UsernameModel.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;
    return null;
  }
}
