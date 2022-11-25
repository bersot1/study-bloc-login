import 'package:formz/formz.dart';

enum PasswordValidationError { empty }

class PasswordModel extends FormzInput<String, PasswordValidationError> {
  const PasswordModel.pure() : super.pure('');
  const PasswordModel.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    return null;
  }
}
