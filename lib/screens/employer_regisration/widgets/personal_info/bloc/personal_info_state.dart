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
      this.idCardPathStringFront = '',
      this.idCardPathStringBack = '',
      this.profilePicturePathString = '',
      this.profilePictureUploadStatus = ImageUploadStatus.pure,
      this.idCardUploadStatusFront = ImageUploadStatus.pure,
      this.idCardUploadStatusBack = ImageUploadStatus.pure,
      this.lastName = const LastName.pure(),
      this.status = FormzStatus.pure,
      this.errorMessage});

  final FormzStatus status;
  final FirstName firstName;
  final LastName lastName;
  final String idCardPathStringFront;
  final String idCardPathStringBack;
  final String profilePicturePathString;
  final ImageUploadStatus idCardUploadStatusFront;
  final ImageUploadStatus idCardUploadStatusBack;
  final ImageUploadStatus profilePictureUploadStatus;
  final String? errorMessage;
  PersonalInfoState copyWith({
    FirstName? firstName,
    LastName? lastName,
    FormzStatus? status,
    String? idCardPathStringFront,
    String? idCardPathStringBack,
    ImageUploadStatus? idCardUploadStatusFront,
    ImageUploadStatus? idCardUploadStatusBack,
    ImageUploadStatus? profilePictureUploadStatus,
    String? profilePicturePathString,
    String? errorMessage,
  }) {
    return PersonalInfoState(
        firstName: firstName ?? this.firstName,
        idCardUploadStatusFront:
            idCardUploadStatusFront ?? this.idCardUploadStatusFront,
        idCardUploadStatusBack:
            idCardUploadStatusBack ?? this.idCardUploadStatusBack,
        profilePictureUploadStatus:
            profilePictureUploadStatus ?? this.profilePictureUploadStatus,
        status: status ?? this.status,
        profilePicturePathString:
            profilePicturePathString ?? this.profilePicturePathString,
        lastName: lastName ?? this.lastName,
        errorMessage: errorMessage,
        idCardPathStringBack: idCardPathStringBack ?? this.idCardPathStringBack,
        idCardPathStringFront:
            idCardPathStringFront ?? this.idCardPathStringFront);
  }

  @override
  List<Object> get props => [
        firstName,
        lastName,
        idCardUploadStatusFront,
        idCardUploadStatusBack,
        profilePicturePathString,
        profilePictureUploadStatus,
        idCardPathStringFront,
        idCardPathStringBack,
        status,
      ];
}
