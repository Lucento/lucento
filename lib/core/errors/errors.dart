import 'package:lucento/core/errors/failures.dart';

class Error extends Failure {
  Error({message}) : super(message: message);
}

class InputError extends Error {
  InputError({message}) : super(message: message);
}
