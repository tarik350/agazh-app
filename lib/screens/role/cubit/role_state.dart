part of 'role_cubit.dart';

class RoleState extends Equatable {
  final UserRole userRole;
  final RoleSubmissionStatus status;

  const RoleState(
      {this.userRole = UserRole.none,
      this.status = RoleSubmissionStatus.invalid});
  RoleState copyWith({UserRole? userRole, RoleSubmissionStatus? status}) {
    return RoleState(
        status: status ?? this.status, userRole: userRole ?? this.userRole);
  }

  @override
  List<Object> get props => [userRole, status];
}
