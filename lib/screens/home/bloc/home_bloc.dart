import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/terms_and_condition/models/confirm_pin.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/terms_and_condition/models/pin.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/employee.dart';

part 'home_event.dart';
part 'home_state.dart';

// home_bloc.dart
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EmployerRepository employerRepository;
  final EmployeeRepository employeeRepository;

  HomeBloc({required this.employerRepository, required this.employeeRepository})
      : super(const HomeState()) {
    on<DeleteEmployeeRequest>(_onDeleteEmployeeRequest);
    on<GetEmployeeRequest>(_onGetEmployeeRequest);
    on<GetEmployee>(_onGetEmployee);
    on<PINChanged>(_onPinChanged);
    on<ConfirmPinChanged>(_onConfirmPinChanged);
    on<ChangePasswordEvent>(_onChangePasswordEvent);
  }

  Future<void> _onDeleteEmployeeRequest(
    DeleteEmployeeRequest event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
        requestDeleteStatus: FormzStatus.submissionInProgress,
        deletingRequestIndex: event.index,
        requests: state.requests));

    try {
      await employerRepository.deleteEmployeeRequest(
          employeeId: event.employeId, employerId: event.employerId);
      final requests = await employerRepository.getRequestsForEmployee();

      emit(state.copyWith(
          requestDeleteStatus: FormzStatus.success,
          deletingRequestIndex: null,
          requests: requests));
    } catch (_) {
      emit(state.copyWith(
        requestDeleteStatus: FormzStatus.submissionFailure,
        deletingRequestIndex: null,
      ));
    }
  }

  FutureOr<void> _onGetEmployeeRequest(
      GetEmployeeRequest event, Emitter<HomeState> emit) async {
    emit(state.copyWith(requestGetStatus: FormzStatus.submissionInProgress));
    try {
      final requests = await employerRepository.getRequestsForEmployee();
      emit(state.copyWith(
          requestGetStatus: FormzStatus.success, requests: requests));
    } catch (e) {
      emit(state.copyWith(requestGetStatus: FormzStatus.submissionFailure));
    }
  }

  FutureOr<void> _onGetEmployee(
      GetEmployee event, Emitter<HomeState> emit) async {
    emit(GetEmployeeLoading());
    try {
      final response = await employeeRepository.fetchEmployeesOrderedByRating(
          workTypeFilter: event.filter, name: event.name);
      if (response == null || response.isEmpty) {
        if (event.filter == null || event.filter!.isEmpty) {
          emit(GetEmployeeEmpty());
        } else {
          emit(GetEmployeeEmptyForFilter(event.filter!));
        }
      } else {
        emit(GetEmployeeLoaded(response));
      }
    } catch (e) {
      emit(GetEmployeeError("Error While Loading employees: ${e.toString()}"));
    }
  }

  FutureOr<void> _onPinChanged(PINChanged event, Emitter<HomeState> emit) {
    final pin = PIN.dirty(event.pin);
    final confirmPin = state.confirmPin.pure
        ? state.confirmPin
        : ConfirmPIN.dirty(password: event.pin, value: state.confirmPin.value);

    emit(state.copyWith(
      pin: pin,
      confirmPin: confirmPin, // Update confirm pin only if it's dirty
      changePinStatus: Formz.validate([pin, confirmPin]),
    ));
  }

  FutureOr<void> _onConfirmPinChanged(
      ConfirmPinChanged event, Emitter<HomeState> emit) {
    final confirmPin =
        ConfirmPIN.dirty(password: state.pin.value, value: event.confirmPin);

    emit(state.copyWith(
      confirmPin: confirmPin,
      changePinStatus: Formz.validate([state.pin, confirmPin]),
    ));
  }

  FutureOr<void> _onChangePasswordEvent(
      ChangePasswordEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(changePinStatus: FormzStatus.submissionInProgress));
      final preference = await SharedPreferences.getInstance();

      final role = preference.getString('role');

      if (role == UserRole.employee.name) {
        await employeeRepository.updateEmployeePassword(state.pin.value);
      } else {
        await employerRepository.updateEmployerPassword(state.pin.value);
      }
      emit(state.copyWith(changePinStatus: FormzStatus.success));
    } catch (e) {
      emit(state.copyWith(
          changePinStatus: FormzStatus.submissionFailure,
          errorMessage: e.toString()));
    }
  }
}
