import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

// home_bloc.dart
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EmployerRepository employerRepository;

  HomeBloc({required this.employerRepository}) : super(const HomeState()) {
    on<DeleteEmployeeRequest>(_onDeleteEmployeeRequest);
    on<GetEmployeeRequest>(_onGetEmployeeRequest);
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
          requestDeleteStatus: FormzStatus.submissionSuccess,
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
          requestGetStatus: FormzStatus.submissionSuccess, requests: requests));
    } catch (e) {
      emit(state.copyWith(requestGetStatus: FormzStatus.submissionFailure));
    }
  }
}
