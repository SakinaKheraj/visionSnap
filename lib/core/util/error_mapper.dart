class ErrorMapper {
  static String map(String error) {
    final lowerError = error.toLowerCase();

    if (lowerError.contains('invalid login credentials')) {
      return 'Incorrect email or password. Please try again.';
    }

    if (lowerError.contains('user already exists')) {
      return 'An account with this email already exists.';
    }

    if (lowerError.contains('email not confirmed')) {
      return 'Please verify your email before logging in.';
    }

    if (lowerError.contains('network') ||
        lowerError.contains('socketexception')) {
      return 'Connection error. Please check your internet.';
    }

    if (lowerError.contains('password should be at least')) {
      return 'Password is too weak. Please use a longer password.';
    }

    if (lowerError.contains('too many requests')) {
      return 'Too many attempts. Please try again later.';
    }

    // Default message if no match found
    return error.length > 100
        ? 'An unexpected error occurred. Please try again.'
        : error;
  }
}
