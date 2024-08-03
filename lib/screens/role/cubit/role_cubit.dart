import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/screens/role/enums/role_status.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';

part 'role_state.dart';

class RoleCubit extends Cubit<RoleState> {
  RoleCubit() : super(const RoleState());

  void setUserRole() {
    // userAuthDetailRepository.setUserRole(role: state.userRole);
    emit(state.copyWith(status: RoleSubmissionStatus.submit));
  }

  void updateSelectedRole(UserRole role) {
    emit(state.copyWith(userRole: role, status: RoleSubmissionStatus.valid));
  }
}
