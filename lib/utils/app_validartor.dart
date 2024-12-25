class AppValidator {
  AppValidator._();

  static String? validateEmpty(String? input) {
    if (input == null) {
      return null;
    }
    return null;
  }

  static String? validatePassword(String? input) {
    if (input == null) return null;
    final regex = RegExp(r'^[a-zA-Z0-9]{8,12}$');
    final isValid = regex.hasMatch(input);
    if (!isValid) {
      return '8-12 characters.\nIncluding letters, numbers';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (password != confirmPassword) {
      return 'Confirm password is not match';
    }
    return null;
  }

  static bool validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null) return false;
    return phoneNumber.replaceAll(RegExp('[^0-9]'), '').length >= 10;
  }

  static bool validateCodeToVerifyPhoneNumber(String? code) {
    if (code == null) return false;
    return code.replaceAll(RegExp('[^0-9]'), '').isNotEmpty;
  }
}
