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
      return true; // Authentifizierung automatisch erfolgreich
    }
    try {
      return await _auth.authenticate(
        localizedReason: "Bitte authentifizieren, um fortzufahren",
        options: const AuthenticationOptions(
          biometricOnly: false, //Geräte-PIN als Fallback zulassen
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      //TODO: Logging hier einfügen
      print("Fehler bei der Authentifizierung: $e");
      return false;
    }
  }

  Future<bool> isDeviceSupported() async {
    try {
      return _auth.isDeviceSupported();
    } on PlatformException catch (e) {
      //TODO: Logging hier einfügen
      print("Das Gerät unterstützt keine Biometrics. $e");
      return false;
    }
  }
}
