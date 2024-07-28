part of 'personal_info_bloc.dart';

enum IDCardUploadStatus { loading, completed, failed, pure }

class PersonalInfoState extends Equatable {
  const PersonalInfoState({
    this.fullName = const FullName.pure(),
    this.familySize = const FamilySize.pure(),
    this.idCardPathString = '',
    this.idCardUploadStatus = IDCardUploadStatus.pure,
    this.status = FormzStatus.pure,
  });

  final FormzStatus status;
  final FullName fullName;
  final FamilySize familySize;
  final String idCardPathString;
  final IDCardUploadStatus idCardUploadStatus;

  PersonalInfoState copyWith(
      {FullName? fullName,
      FormzStatus? status,
      String? idCardPathString,
      IDCardUploadStatus? idCardUploadStatus,
      FamilySize? familySize}) {
    return PersonalInfoState(
        fullName: fullName ?? this.fullName,
        idCardUploadStatus: idCardUploadStatus ?? this.idCardUploadStatus,
        status: status ?? this.status,
        familySize: familySize ?? this.familySize,
        idCardPathString: idCardPathString ?? this.idCardPathString);
  }

  @override
  List<Object> get props =>
      [familySize, fullName, idCardUploadStatus, idCardPathString, status];
}
