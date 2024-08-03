import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<int> {
  final int initialPageIndex;
  AppCubit(this.initialPageIndex) : super(initialPageIndex);

  void changeView(int index) {
    emit(index);
  }
}
