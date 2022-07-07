import 'package:formz/formz.dart';

/// Validation errors for the [Name] [FormzInput].
enum TextValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Name}
/// Form input for an Name input.
/// {@endtemplate}
class TextInput extends FormzInput<String, TextValidationError> {
  /// {@macro Name}
  const TextInput.pure() : super.pure('');

  /// {@macro Name}
  const TextInput.dirty([String value = '']) : super.dirty(value);

  @override
  TextValidationError? validator(String? value) {
    return value != '' ? null : TextValidationError.invalid;
  }
}
