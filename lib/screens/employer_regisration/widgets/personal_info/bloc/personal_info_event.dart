part of 'personal_info_bloc.dart';

abstract class PersonalInfoEvent extends Equatable {
  const PersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class FullNameChanged extends PersonalInfoEvent {
  final String name;
  const FullNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class FamilySizeChanged extends PersonalInfoEvent {
  final String familySize;

  const FamilySizeChanged(this.familySize);
  @override
  List<Object> get props => [familySize];
}

class IdCardChanged extends PersonalInfoEvent {
  final Uint8List file;
  final String path;

  const IdCardChanged({required this.file, required this.path});

  @override
  List<Object> get props => [file, path];
}

class FormSubmitted extends PersonalInfoEvent {}
