import 'package:get_it/get_it.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/services/firestore_service.dart';

final getit = GetIt.instance;

Future<void> initApp() async {
  var authService = AuthService();
  final firestoreService = FirebaseService();
  getit.registerSingleton<AuthService>(authService);
  await authService.initAuthStatus();
  getit.registerSingleton<FirebaseService>(firestoreService);
}
