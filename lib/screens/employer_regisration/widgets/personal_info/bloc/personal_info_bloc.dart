import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/auth_detail_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';

import 'package:mobile_app/screens/employer_regisration/widgets/personal_info/models/FullName.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/personal_info/models/family_size.dart';
import 'package:mobile_app/services/firestore_service.dart';

part 'personal_info_event.dart';
part 'personal_info_state.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  final EmployerRepositroy employerRepositroy;
  final UserAuthDetailRepository userAuthDetailRepository;
  final FirebaseService _firebaseService = FirebaseService();

  PersonalInfoBloc(
      {required this.employerRepositroy,
      required this.userAuthDetailRepository})
      : super(const PersonalInfoState()) {
    on<FullNameChanged>(_onNameChanged);
    on<FamilySizeChanged>(_onFamilySizeChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<IdCardChanged>(_onIdCardChanged);
  }

  void _onNameChanged(
    FullNameChanged event,
    Emitter<PersonalInfoState> emit,
  ) {
    final name = FullName.dirty(event.name);
    emit(state.copyWith(
      fullName: name,
      status: Formz.validate([name, state.familySize]),
    ));
  }

  FutureOr<void> _onFamilySizeChanged(
      FamilySizeChanged event, Emitter<PersonalInfoState> emit) {
    final familySize = FamilySize.dirty(event.familySize);
    emit(state.copyWith(
        familySize: familySize,
        status: Formz.validate([state.fullName, familySize])));
  }

  // void _onPhoneNumberChanged(
  //   PhoneNumberChanged event,
  //   Emitter<PersonalInfoState> emit,
  // ) {
  //   final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
  //   emit(state.copyWith(
  //     phoneNumber: phoneNumber,
  //     status: Formz.validate([state.email, state.name, phoneNumber]),
  //   ));
  // }
  FutureOr<void> _onIdCardChanged(
      IdCardChanged event, Emitter<PersonalInfoState> emit) async {
    emit(state.copyWith(idCardUploadStatus: IDCardUploadStatus.loading));
    try {
      final response =
          await _firebaseService.uploadImgeToStorage(event.path, event.file);
      if (response.isNotEmpty) {
        emit(state.copyWith(
            idCardUploadStatus: IDCardUploadStatus.completed,
            idCardPathString: response));
        //todo update the personal info
      } else {}
    } catch (e) {
      emit(state.copyWith(idCardUploadStatus: IDCardUploadStatus.failed));
    }
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<PersonalInfoState> emit,
  ) async {
    if (state.status.isValidated) {
      if (state.idCardUploadStatus != IDCardUploadStatus.completed) {
        emit(state.copyWith(idCardUploadStatus: IDCardUploadStatus.failed));
      }

      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        employerRepositroy.updatePersonalInfo(
            userAuthDetail: userAuthDetailRepository.getUserAuthDetail(),
            fullName: state.fullName.value,
            idCardPathString: state.idCardPathString);

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
