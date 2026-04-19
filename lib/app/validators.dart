import 'package:email_validator/email_validator.dart';

class Validators {

  // --------- For value Validation -------------
  static String ? validateNullOrEmpty(String ? value, String invalidMessage) {
    if (value == null || value.isEmpty) {
      return invalidMessage;
    } else {
      return null;
    }
  }

  // --------- For Email Validation --------
  static String ? validateEmail(String ? value) {
    if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
      return "Enter a valid email address";
    } else {
      return null;
    }
  }

  // --------- For Password Validation ----------
  static String ? validatePassword(String ? value) {
    if ( value == null || value.isEmpty || value.length < 6 ) {
      return 'Enter a valid password or must be at least 6 characters';
    } else {
      return null ;
    }
  }

}