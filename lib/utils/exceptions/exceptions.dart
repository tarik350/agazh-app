class VerificationIdNotReceivedException implements Exception {
  final String message;

  VerificationIdNotReceivedException(
      [this.message = "Verification ID was not received."]);

  @override
  String toString() {
    return message;
  }
}
