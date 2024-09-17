class VerificationIdNotReceivedException implements Exception {
  final String message;

  VerificationIdNotReceivedException(
      [this.message = "Verification ID was not received."]);

  @override
  String toString() {
    return message;
  }
}

class RoleCanNotBeNoneException implements Exception {
  final String message;

  RoleCanNotBeNoneException([this.message = 'Role cannot be none']);

  @override
  String toString() => 'RoleCanNotBeNoneException: $message';
}

class UserAlreadyExistException implements Exception {
  final String message;
  UserAlreadyExistException([this.message = "User already exists"]);

  @override
  String toString() => message;
}

class UserDoesNotExist implements Exception {
  final String message;
  UserDoesNotExist([this.message = "User does not exists"]);

  @override
  String toString() => message;
}

class RatingAlreadyAddedException implements Exception {
  final String message;
  RatingAlreadyAddedException(this.message);
}

class RequestAlreadySent implements Exception {
  final String message;
  RequestAlreadySent(this.message);
}

class AccountNotActive implements Exception {
  final String message;
  AccountNotActive(this.message);
}
