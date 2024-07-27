part of 'role_cubit.dart';

class RoleState extends Equatable {
  final SelectedRole role;
  final RoleSubmissionStatus status;

  const RoleState(
      {this.role = SelectedRole.unknown,
      this.status = RoleSubmissionStatus.invalid});
  RoleState copyWith({SelectedRole? role, RoleSubmissionStatus? status}) {
    return RoleState(status: status ?? this.status, role: role ?? this.role);
  }

  @override
  List<Object> get props => [role, status];
}
