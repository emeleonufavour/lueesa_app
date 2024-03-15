class LValidator {
  //this validator checks for name
  static validateName(String value) {
    if (value.isEmpty) {
      return 'You need to enter a name';
    }
    if (value.isEmpty || !RegExp(r'^[A-Za-z\s-]+$').hasMatch(value)) {
      return "Enter a correct name";
    } else {
      return null;
    }
  }

  //this validator checks for email
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    if (value.isEmpty ||
        !RegExp(r'^[a-zA-Z0-9._%+-]+@lueesa\.lmu\.edu\.ng$').hasMatch(value)) {
      return "Enter a correct Email Address";
    }
    return null;
  }

  static String? validatePassword(String password) {
    // These are password validation rules
    //We make sure password length is greater than 8
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // We make sure each password must contain at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // We make sure each password must contain at least one lowercase letter
    // if (!password.contains(RegExp(r'[a-z]'))) {
    //   return 'Password must contain at least one lowercase letter';
    // }

    // We make sure each password must contain at least one digit
    // if (!password.contains(RegExp(r'[0-9]'))) {
    //   return 'Password must contain at least one digit';
    // }

    //We make sure the password contains a special character
    // if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Password must contain at least one special character';
    // }

    return null; // Password is valid
  }

  static String? validatePhoneNumber(String phoneNumber) {
    // Use a regular expression to check if the phone number follows the desired format
    if (!RegExp(r'^\+\d{13}$').hasMatch(phoneNumber)) {
      return 'It should start with "+", followed by 13 digits';
    }

    return null; // Phone number is valid
  }
}
