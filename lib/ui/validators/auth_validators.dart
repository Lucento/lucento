import 'package:lucento/core/utils/extensions/string_extension.dart';

String emailValidator(String email) {
  if (email.isEmpty) {
    return "Email is required!";
  } else if (!email.isEmail()) {
    return "Invalid Email Address!";
  }
  return null;
}

String passwordValidator(String password) {
  if (password.length < 6) {
    return "Password should be atleast of 6 characters!";
  }
  return null;
}

String phoneValidator(String phone) {
  if (phone.isNotEmpty && phone.length != 10) {
    return "Invalid phone number!";
  }
  return null;
}

String emptyValidator(String value) {
  if (value.isEmpty) return "Required!";
  return null;
}
