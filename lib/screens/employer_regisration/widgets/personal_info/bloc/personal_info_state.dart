part of 'personal_info_bloc.dart';

enum ImageUploadStatus {
  loading,
  completed,
  failed,
  pure,
  notUploaded,
}

class PersonalInfoState extends Equatable {
  const PersonalInfoState(
      {this.fullName = const FullName.pure(),
      this.idCardPathString = '',
      this.profilePicturePathString = '',
      this.profilePictureUploadStatus = ImageUploadStatus.pure,
      this.idCardUploadStatus = ImageUploadStatus.pure,
      this.status = FormzStatus.pure,
      this.errorMessage});

  final FormzStatus status;
  final FullName fullName;
  final String idCardPathString;
  final String profilePicturePathString;
  final ImageUploadStatus idCardUploadStatus;
  final ImageUploadStatus profilePictureUploadStatus;
  final String? errorMessage;
  PersonalInfoState copyWith({
    FullName? fullName,
    FormzStatus? status,
    String? idCardPathString,
    ImageUploadStatus? idCardUploadStatus,
    ImageUploadStatus? profilePictureUploadStatus,
    String? profilePicturePathString,
    String? errorMessage,
  }) {
    return PersonalInfoState(
        fullName: fullName ?? this.fullName,
        idCardUploadStatus: idCardUploadStatus ?? this.idCardUploadStatus,
        profilePictureUploadStatus:
            profilePictureUploadStatus ?? this.profilePictureUploadStatus,
        status: status ?? this.status,
        profilePicturePathString:
            profilePicturePathString ?? this.profilePicturePathString,
        errorMessage: errorMessage,
        idCardPathString: idCardPathString ?? this.idCardPathString);
  }

  @override
  List<Object> get props => [
        fullName,
        idCardUploadStatus,
        profilePicturePathString,
        profilePictureUploadStatus,
        idCardPathString,
        status,
      ];
}
