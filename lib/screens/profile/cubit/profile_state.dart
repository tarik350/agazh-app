part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class ProfileUpdated extends ProfileState {}

class ProfileUpdateError extends ProfileState {
  final String message;

  const ProfileUpdateError(this.message);
}

class ProfileUpdating extends ProfileState {}

class IdCardUploaded extends ProfileState {
  final String path;

  const IdCardUploaded(this.path);
}

class ProfilePictureUploaded extends ProfileState {
  final String path;

  const ProfilePictureUploaded(this.path);
}

class ImageUploadError extends ProfileState {
  final String message;

  const ImageUploadError(this.message);
}

class IdCardUploading extends ProfileState {}

class ProfilePicutureUploading extends ProfileState {}
