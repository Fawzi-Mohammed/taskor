final RegExp _emailRegex = RegExp(
  r'^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$',
  caseSensitive: false,
);
final RegExp _digitsOnlyRegex = RegExp(r'^\d+$');
final RegExp _upperCaseRegex = RegExp(r'[A-Z]');
final RegExp _lowerCaseRegex = RegExp(r'[a-z]');
final RegExp _hasDigitRegex = RegExp(r'\d');

extension ValidationExtension on String? {
  static const String requiredFieldMessage = 'This field is required.';
  String? get _trimmed => this?.trim();

  bool get isNullOrEmpty {
    final value = _trimmed;
    return value == null || value.isEmpty;
  }

  bool get isValidEmail {
    final value = _trimmed;
    if (value == null) {
      return false;
    }
    return _emailRegex.hasMatch(value);
  }

  bool get isDigitsOnly {
    final value = _trimmed;
    if (value == null || value.isEmpty) {
      return false;
    }
    return _digitsOnlyRegex.hasMatch(value);
  }

  String? validateRequired({String fieldName = 'Field'}) {
    if (isNullOrEmpty) {
      return requiredFieldMessage;
    }
    return null;
  }

  String? validateEmail({String fieldName = 'Email'}) {
    if (isNullOrEmpty) {
      return requiredFieldMessage;
    }
    if (!isValidEmail) {
      return 'Please enter a valid $fieldName.';
    }
    return null;
  }

  String? validatePassword({int minLength = 8, String fieldName = 'Password'}) {
    final value = _trimmed;
    if (value == null || value.isEmpty) {
      return requiredFieldMessage;
    }
    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters.';
    }
    final hasUppercase = _upperCaseRegex.hasMatch(value);
    final hasLowercase = _lowerCaseRegex.hasMatch(value);
    final hasNumber = _hasDigitRegex.hasMatch(value);

    if (!hasUppercase || !hasLowercase || !hasNumber) {
      return '$fieldName must include uppercase, lowercase, and a number.';
    }
    return null;
  }

  String? validateConfirmPassword(
    String? original, {
    String fieldName = 'Password',
  }) {
    final value = _trimmed;
    if (value == null || value.isEmpty) {
      return requiredFieldMessage;
    }
    final originalTrimmed = original?.trim();
    if (originalTrimmed == null || originalTrimmed.isEmpty) {
      return requiredFieldMessage;
    }
    if (value != originalTrimmed) {
      return '$fieldName does not match.';
    }
    return null;
  }

  String? validateName({String fieldName = 'Name', int minLength = 2}) {
    final value = _trimmed;
    if (value == null || value.isEmpty) {
      return requiredFieldMessage;
    }
    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters.';
    }
    return null;
  }

  String? validateHourlyRate({String fieldName = 'Hourly rate'}) {
    final value = _trimmed;
    if (value == null || value.isEmpty) {
      return requiredFieldMessage;
    }
    final normalized = value.replaceAll(',', '').replaceAll('\$', '');
    final rate = double.tryParse(normalized);
    if (rate == null) {
      return 'Please enter a valid $fieldName.';
    }
    if (rate <= 0) {
      return '$fieldName must be greater than 0.';
    }
    return null;
  }

  String? validateCode({int length = 4, String fieldName = 'Code'}) {
    final value = _trimmed;
    if (value == null || value.isEmpty) {
      return requiredFieldMessage;
    }
    if (!_digitsOnlyRegex.hasMatch(value)) {
      return '$fieldName must contain only digits.';
    }
    if (value.length != length) {
      return '$fieldName must be $length digits.';
    }
    return null;
  }
}
