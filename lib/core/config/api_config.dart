import 'package:flutter/foundation.dart';

class ApiConfig {
  /// Windows desktop: localhost. Android emulator: 10.0.2.2.
  /// Real phone: your PC's LAN IP, or a deployed https URL.
  static String get baseUrl {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:5000/api';
    }
    return 'http://localhost:5000/api';
  }
}