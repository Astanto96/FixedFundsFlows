import 'package:fixedfundsflows/data/services/authentication_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  //wieso "bool?"?
  //build() ist die Initialisierungsmethode der Riverpod Generator Klasse
  //den wert den build() zurück gibt, ist der Anfangswert von "state"
  //er kann "null" sein, wenn das Gerät noch nicht authentifiziert wurde
  //true wenn erfolgreich auth
  //false wenn auth fehlgeschlagen
  //beim setzen von state, werden alle Views die watchen, aktualisiert
  bool? build() {
    return null; //Startwert: "Noch keine Authentifizierung"
  }

  Future<void> authenticate() async {
    final authService = ref.read(authenticationServiceProvider);
    final bool success = await authService.authenticate();
    state = success;
  }
}
