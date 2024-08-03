import 'package:mobile_app/data/models/UserAuthDetail.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';

class UserAuthDetailRepository {
  UserAuthDetail? _authDetail;
  UserAuthDetail getUserAuthDetail() {
    return _authDetail ?? UserAuthDetail.empty();
  }

  void setUserPhone({
    required String phoneNumber,
  }) {
    _authDetail ??= UserAuthDetail.empty();
    _authDetail = _authDetail?.copyWith(phoneNumber: phoneNumber);
  }

  void setUserRole({required UserRole role}) {
    _authDetail ??= UserAuthDetail.empty();
    _authDetail = _authDetail?.copyWith(role: role);
  }

  void setUserPassword(String password) {
    _authDetail ??= UserAuthDetail.empty();
    _authDetail = _authDetail?.copyWith(password: password);
  }

  UserRole getUserRole() {
    if (_authDetail != null) {
      return _authDetail!.role;
    } else {
      return UserRole.none;
    }
  }
}
