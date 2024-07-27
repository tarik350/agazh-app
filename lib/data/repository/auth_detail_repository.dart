import 'package:mobile_app/data/models/UserAuthDetail.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';

class UserAuthDetailRepository {
  UserAuthDetail? _authDetail;
  UserAuthDetail getUserAuthDetail() {
    return _authDetail ?? UserAuthDetail.empty();
  }

  void initUserAuthDetail(
      {required String fullName,
      required String phoneNumber,
      required String password}) {
    _authDetail ??= UserAuthDetail.empty();
    _authDetail = _authDetail?.copyWith(
        fullName: fullName, phoneNumber: phoneNumber, password: password);
  }

  void updateUserRole({required SelectedRole role}) {
    _authDetail ??= UserAuthDetail.empty();
    _authDetail = _authDetail?.copyWith(role: role);
  }

  SelectedRole getUserRole() {
    if (_authDetail != null) {
      return _authDetail!.role;
    } else {
      return SelectedRole.unknown;
    }
  }
}
