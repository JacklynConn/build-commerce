class MyValidators {
  static String? displayNameValidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return 'Display Name can\'t be empty';
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return 'Display Name must be between 3 and 20 characters';
    }
    return null; // Return null if display Name is valid
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? repeatPasswordValidator(String? value, String? password) {
    if (value != password) {
      return 'Passwords don\'t match';
    }
    return null;
  }
}
