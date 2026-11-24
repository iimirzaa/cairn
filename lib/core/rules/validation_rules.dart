/// Pure Dart. No Flutter imports.
class ValidationRules {
  static const int maxNameLength = 30;

  static String? required(String? v, String label) =>
      (v == null || v.trim().isEmpty) ? '$label is required' : null;

  /// Person name: letters, spaces, and . ' - only. No numbers. Max 30 chars.
  static String? personName(String? v, {String label = 'Full name'}) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return '$label is required';
    if (RegExp(r'\d').hasMatch(value)) return '$label cannot contain numbers';
    if (!RegExp(r"^[\p{L} .'-]+$", unicode: true).hasMatch(value)) {
      return '$label contains invalid characters';
    }
    if (value.length > maxNameLength) {
      return '$label must be $maxNameLength characters or less';
    }
    return null;
  }

  /// Company name: same as above, but also allows & and , (e.g. "Smith & Sons, Ltd").
  static String? companyName(String? v, {String label = 'Company name'}) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return '$label is required';
    if (RegExp(r'\d').hasMatch(value)) return '$label cannot contain numbers';
    if (!RegExp(r"^[\p{L} .,&'-]+$", unicode: true).hasMatch(value)) {
      return '$label contains invalid characters';
    }
    if (value.length > maxNameLength) {
      return '$label must be $maxNameLength characters or less';
    }
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'Enter a valid email';
  }

  static String? phone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Phone number is required';
    final digits = v.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 10 ? null : 'Enter a valid phone number';
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 8) return 'Use at least 8 characters';
    if (!RegExp(r'\d').hasMatch(v)) return 'Include at least one number';
    if (!RegExp(r'[^A-Za-z0-9]').hasMatch(v)) {
      return 'Include at least one symbol';
    }
    return null;
  }
}