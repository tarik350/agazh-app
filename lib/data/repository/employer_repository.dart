import 'package:mobile_app/data/models/Employer.dart';
import 'package:mobile_app/data/models/UserAuthDetail.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';

class EmployerRepositroy {
  Employeer? _user;

  Employeer getUser() {
    return _user ?? Employeer.empty();
  }

  void updatePersonalInfo(
      {required String name,
      required String email,
      required String phoneNumber,
      required UserAuthDetail userAuthDetail}) async {
    _user ??= Employeer.empty();

    _user = _user?.copyWith(
      userAuthDetail: userAuthDetail,
      personalInfo:
          PersonalInfo(name: name, email: email, phoneNumber: phoneNumber),
    );
  }

  void updateAddressInfo({
    required String houseNumber,
    required String familySize,
    required String city,
    required String idCardImage,
  }) async {
    _user ??= Employeer.empty();
    _user = _user?.copyWith(
      addressInfo: AddressInfo(
        houseNumber: houseNumber,
        familySize: familySize,
        city: city,
        idCardImage: idCardImage,
      ),
    );
  }

  void updateUserAuthDetail({
    required String fullName,
    required String phoneNumber,
    required String password,
    required SelectedRole role,
  }) async {
    _user ??= Employeer.empty();
    _user = _user?.copyWith(
      userAuthDetail: UserAuthDetail(
        fullName: fullName,
        phoneNumber: phoneNumber,
        password: password,
        role: role,
      ),
    );
  }
}
