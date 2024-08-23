String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a username';
  }

  if (value.length < 3 || value.length > 23) {
    return 'Username must be between 3 and 23 characters';
  }

  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }

  final symbolRegex = RegExp(r'[!@#$%^&*()_+]');
  final uppercaseRegex = RegExp(r'[A-Z]');

  if (!symbolRegex.hasMatch(value) || !uppercaseRegex.hasMatch(value)) {
    return 'Password must contain at least one symbol and one uppercase letter';
  }

  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }

  return null;
}

String? confirmPassword(String password, String value) {
  if (value != password) {
    return 'Password does not match';
  }

  return null;
}
