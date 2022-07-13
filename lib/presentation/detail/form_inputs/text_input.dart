import 'package:formz/formz.dart';

enum TextValidationError { invalid }

class TextInput extends FormzInput<String, TextValidationError> {
  const TextInput.pure() : super.pure('');

  const TextInput.dirty([String value = '']) : super.dirty(value);

  @override
  TextValidationError? validator(String? value) {
    return value != '' ? null : TextValidationError.invalid;
  }
}