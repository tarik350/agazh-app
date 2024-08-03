import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/models/employee.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/utils/exceptions/exceptions.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository employeeRepository;
  EmployeeCubit(this.employeeRepository) : super(const EmployeeState());
  void updateRating(
      {required double rating,
      required String employeeId,
      required String employerId}) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      bool alreadyRated =
          await employeeRepository.hasRating(employeeId, employerId);
      if (alreadyRated) {
        throw RatingAlreadyAddedException('Rating already added.');
      }

      await employeeRepository.addRating(
          employeeId: employeeId, employerId: employerId, rating: rating);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on RatingAlreadyAddedException catch (r) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: r.message));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }

  void setRating(double rating) {
    state.copyWith(rating: rating);
  }

  void requestForEmployee(
      {required String employeeId,
      required String employerId,
      required String fullName}) async {
    try {
      emit(state.copyWith(requestStatus: FormzStatus.submissionInProgress));

      bool alreadyRequested = await employeeRepository.hasRequest(
          employerId: employerId, employeeId: employeeId);
      if (alreadyRequested) {
        throw RequestAlreadySent(
            'You have already sent a request for $fullName');
      }
      await employeeRepository.requestEmployee(
          employeeId: employeeId, employerId: employerId);
      emit(state.copyWith(requestStatus: FormzStatus.submissionSuccess));
    } on RequestAlreadySent catch (e) {
      emit(state.copyWith(
          requestStatus: FormzStatus.submissionFailure,
          errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          requestStatus: FormzStatus.submissionFailure,
          errorMessage: e.toString()));
    }
  }
}
