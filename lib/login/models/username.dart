import 'package:formz/formz.dart';

enum UsernameValidationError { lessThanFourCharacters }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    return value!.length >= 4 ? null 
    : UsernameValidationError.lessThanFourCharacters;
  }
}
