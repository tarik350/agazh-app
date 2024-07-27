import 'package:get_it/get_it.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:mobile_app/services/role_service.dart';

final getit = GetIt.instance;

Future<void> initApp() async {
  final authService = AuthService();
  final roleService = RoleService();
  final firestoreService = FirestoreService();

  getit.registerSingleton<AuthService>(authService);
  getit.registerSingleton<RoleService>(roleService);
  getit.registerSingleton<FirestoreService>(firestoreService);
}
