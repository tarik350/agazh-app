part of 'personal_info_bloc.dart';

enum ImageUploadStatus {
  loading,
  completed,
  failed,
  pure,
  notUploaded,
}

class PersonalInfoState extends Equatable {
  const PersonalInfoState({
    this.fullName = const FullName.pure(),
    this.familySize = const FamilySize.pure(),
    this.idCardPathString = '',
    this.profilePicturePathString = '',
    this.profilePictureUploadStatus = ImageUploadStatus.pure,
    this.idCardUploadStatus = ImageUploadStatus.pure,
    this.status = FormzStatus.pure,
  });

  final FormzStatus status;
  final FullName fullName;
  final FamilySize familySize;
  final String idCardPathString;
  final String profilePicturePathString;
  final ImageUploadStatus idCardUploadStatus;
  final ImageUploadStatus profilePictureUploadStatus;

  PersonalInfoState copyWith(
      {FullName? fullName,
      FormzStatus? status,
      String? idCardPathString,
      ImageUploadStatus? idCardUploadStatus,
      ImageUploadStatus? profilePictureUploadStatus,
      String? profilePicturePathString,
      FamilySize? familySize}) {
    return PersonalInfoState(
        fullName: fullName ?? this.fullName,
        idCardUploadStatus: idCardUploadStatus ?? this.idCardUploadStatus,
        profilePictureUploadStatus:
            profilePictureUploadStatus ?? this.profilePictureUploadStatus,
        status: status ?? this.status,
        familySize: familySize ?? this.familySize,
        profilePicturePathString:
            profilePicturePathString ?? this.profilePicturePathString,
        idCardPathString: idCardPathString ?? this.idCardPathString);
  }

  @override
  List<Object> get props => [
        familySize,
        fullName,
        idCardUploadStatus,
        profilePicturePathString,
        profilePictureUploadStatus,
        idCardPathString,
        status
      ];
}
