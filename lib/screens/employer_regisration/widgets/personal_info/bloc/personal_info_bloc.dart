import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/personal_info/models/FullName.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:mobile_app/services/firestore_service.dart';

part 'personal_info_event.dart';
part 'personal_info_state.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  final EmployerRepository employerRepositroy;
  final EmployeeRepository employeeRepository;
  final _auth = FirebaseAuth.instance;
  final FirebaseService _firebaseService = FirebaseService();

  PersonalInfoBloc(
      {required this.employerRepositroy, required this.employeeRepository})
      : super(const PersonalInfoState()) {
    on<FullNameChanged>(_onNameChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<IdCardChanged>(_onIdCardChanged);
    on<ProfilePictureChanged>(_onProfilePictureChanged);
  }

  void _onNameChanged(
    FullNameChanged event,
    Emitter<PersonalInfoState> emit,
  ) {
    final name = FullName.dirty(event.name);
    emit(state.copyWith(
      fullName: name,
      status: Formz.validate([name]),
    ));
  }

  FutureOr<void> _onIdCardChanged(
      IdCardChanged event, Emitter<PersonalInfoState> emit) async {
    emit(state.copyWith(idCardUploadStatus: ImageUploadStatus.loading));
    try {
      final response =
          await _firebaseService.uploadImgeToStorage(event.path, event.file);
      if (response.isNotEmpty) {
        emit(state.copyWith(
            idCardUploadStatus: ImageUploadStatus.completed,
            idCardPathString: response));
        //todo update the personal info
      } else {}
    } catch (e) {
      emit(state.copyWith(idCardUploadStatus: ImageUploadStatus.failed));
    }
  }

  FutureOr<void> _onProfilePictureChanged(
      ProfilePictureChanged event, Emitter<PersonalInfoState> emit) async {
    emit(state.copyWith(profilePictureUploadStatus: ImageUploadStatus.loading));
    try {
      final response =
          await _firebaseService.uploadImgeToStorage(event.path, event.file);
      if (response.isNotEmpty) {
        emit(state.copyWith(
            profilePictureUploadStatus: ImageUploadStatus.completed,
            profilePicturePathString: response));
      } else {}
    } catch (e) {
      emit(state.copyWith(
          profilePictureUploadStatus: ImageUploadStatus.failed,
          errorMessage: "Error uploading profile picture"));
    }
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<PersonalInfoState> emit,
  ) async {
    if (state.status.isValidated) {
      if (state.idCardUploadStatus != ImageUploadStatus.completed) {
        emit(state.copyWith(
            idCardUploadStatus: ImageUploadStatus.notUploaded,
            errorMessage: "Id card must be uploaded"));

        return;
      }

      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        if (event.role == UserRole.employer) {
          employerRepositroy.updatePersonalInfo(
              fullName: state.fullName.value,
              idCardImagePath: state.idCardPathString,
              id: _auth.currentUser!.uid,
              profilePicturePath: state.profilePicturePathString);
        } else {
          employeeRepository.updatePersonalInfo(
              fullName: state.fullName.value,
              idCardImagePath: state.idCardPathString,
              profilePicturePath: state.profilePicturePathString,
              id: _auth.currentUser!.uid);
        }

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure, errorMessage: e.toString()));
      }
    }
  }
}
