import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';

part 'termsandcondition_state.dart';

class TermsandconditionCubit extends Cubit<TermsandconditionState> {
  final EmployerRepositroy employerRepositroy;
  TermsandconditionCubit({required this.employerRepositroy})
      : super(TermsandconditionInitial());
}
