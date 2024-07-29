import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/repository/auth_detail_repository.dart';
import 'package:mobile_app/screens/role/enums/role_status.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';

part 'role_state.dart';

class RoleCubit extends Cubit<RoleState> {
  final UserAuthDetailRepository userAuthDetailRepository;
  RoleCubit({required this.userAuthDetailRepository})
      : super(const RoleState());

  void setUserRole() {
    userAuthDetailRepository.setUserRole(role: state.role);
    emit(state.copyWith(status: RoleSubmissionStatus.submit));
  }

  void updateSelectedRole(SelectedRole role) {
    emit(state.copyWith(role: role, status: RoleSubmissionStatus.valid));
  }
}
