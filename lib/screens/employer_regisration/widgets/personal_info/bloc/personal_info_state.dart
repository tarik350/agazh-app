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
      {this.firstName = const FirstName.pure(),
      this.idCardPathString = '',
      this.profilePicturePathString = '',
      this.profilePictureUploadStatus = ImageUploadStatus.pure,
      this.idCardUploadStatus = ImageUploadStatus.pure,
      this.lastName = const LastName.pure(),
      this.status = FormzSubmissionStatus.initial,
      this.errorMessage});

  final FormzSubmissionStatus status;
  final FirstName firstName;
  final LastName lastName;
  final String idCardPathString;
  final String profilePicturePathString;
  final ImageUploadStatus idCardUploadStatus;
  final ImageUploadStatus profilePictureUploadStatus;
  final String? errorMessage;
  PersonalInfoState copyWith({
    FirstName? firstName,
    LastName? lastName,
    FormzSubmissionStatus? status,
    String? idCardPathString,
    ImageUploadStatus? idCardUploadStatus,
    ImageUploadStatus? profilePictureUploadStatus,
    String? profilePicturePathString,
    String? errorMessage,
  }) {
    return PersonalInfoState(
        firstName: firstName ?? this.firstName,
        idCardUploadStatus: idCardUploadStatus ?? this.idCardUploadStatus,
        profilePictureUploadStatus:
            profilePictureUploadStatus ?? this.profilePictureUploadStatus,
        status: status ?? this.status,
        profilePicturePathString:
            profilePicturePathString ?? this.profilePicturePathString,
        lastName: lastName ?? this.lastName,
        errorMessage: errorMessage,
        idCardPathString: idCardPathString ?? this.idCardPathString);
  }

  @override
  List<Object> get props => [
        firstName,
        lastName,
        idCardUploadStatus,
        profilePicturePathString,
        profilePictureUploadStatus,
        idCardPathString,
        status,
      ];
}
