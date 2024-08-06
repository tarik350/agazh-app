import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';

import '../../../../services/firestore_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final EmployerRepository employerRepository;
  final EmployeeRepository employeeRepository;
  final FirebaseService _firebaseService = FirebaseService();

  ProfileCubit(
      {required this.employerRepository, required this.employeeRepository})
      : super(ProfileInitial());

  Future<void> updateProfile(
      String id, Map<String, dynamic> updatedFields, UserRole role) async {
    emit(ProfileUpdating());
    try {
      if (role == UserRole.employee) {
        await employeeRepository.updateEmployeeProfile(
            employeeId: id, updatedFields: updatedFields);
      } else {
        await employerRepository.updateEmployerProfile(
            employerId: id, updatedFields: updatedFields);
      }

      emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileUpdateError(e.toString()));
    }
  }

  Future<void> uploadIdCard(
      {required Uint8List file, required String path}) async {
    emit(IdCardUploading());
    try {
      final response = await _firebaseService.uploadImgeToStorage(path, file);
      if (response.isNotEmpty) {
        emit(IdCardUploaded(response));
      }
    } catch (e) {
      emit(ImageUploadError("Error while uploading ID card: ${e.toString()}"));
    }
  }

  Future<void> uploadProfilePicture(
      {required Uint8List file,
      required String path,
      required String id}) async {
    emit(ProfilePicutureUploading());
    try {
      final response =
          await _firebaseService.uploadImgeToStorage(path, file, fileName: id);
      if (response.isNotEmpty) {
        emit(ProfilePictureUploaded(response));
      }
    } catch (e) {
      emit(ImageUploadError("Error while uploading ID card: ${e.toString()}"));
    }
  }
}
