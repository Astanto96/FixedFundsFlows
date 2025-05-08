// ignore_for_file: avoid_redundant_argument_values, avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_service.g.dart';

@riverpod
AuthenticationService authenticationService(Ref ref) {
  return AuthenticationService();
}

class AuthenticationService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    if (kDebugMode) {
      print("🚀 Debug-Modus: Authentifizierung wird übersprungen!");
      return true; // Authentication automatically successful
    }
    try {
      return await _auth.authenticate(
        localizedReason: "Please authenticate to continue",
        options: const AuthenticationOptions(
          biometricOnly: false, //Allow device PIN as fallback
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      print("Authentication error: $e");
      return false;
    }
  }

  Future<bool> isDeviceSupported() async {
    try {
      return _auth.isDeviceSupported();
    } on PlatformException catch (e) {
      print("The device does not support biometrics. $e");
      return false;
    }
  }
}
