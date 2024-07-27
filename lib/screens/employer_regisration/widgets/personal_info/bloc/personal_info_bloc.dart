import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/auth_detail_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';

import 'package:mobile_app/screens/auth/register/models/phone_number.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/personal_info/models/email.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/personal_info/models/name.dart';

part 'personal_info_event.dart';
part 'personal_info_state.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  final EmployerRepositroy employerRepositroy;
  final UserAuthDetailRepository userAuthDetailRepository;

  PersonalInfoBloc(
      {required this.employerRepositroy,
      required this.userAuthDetailRepository})
      : super(const PersonalInfoState()) {
    on<EmailChanged>(_onEmailChanged);
    on<NameChanged>(_onNameChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onEmailChanged(
    EmailChanged event,
    Emitter<PersonalInfoState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.name, state.phoneNumber]),
    ));
  }

  void _onNameChanged(
    NameChanged event,
    Emitter<PersonalInfoState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([state.email, name, state.phoneNumber]),
    ));
  }

  void _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<PersonalInfoState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([state.email, state.name, phoneNumber]),
    ));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<PersonalInfoState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        employerRepositroy.updatePersonalInfo(
          userAuthDetail: userAuthDetailRepository.getUserAuthDetail(),
          name: state.name.value,
          email: state.email.value,
          phoneNumber: state.phoneNumber.value,
        );

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
