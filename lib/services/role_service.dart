import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/services/init_service.dart';

class RoleService {
  final _authService = getit<AuthService>();
  void addUserRole(String role) {
    _authService.updateUser(
      role: role,
    );
  }
}
