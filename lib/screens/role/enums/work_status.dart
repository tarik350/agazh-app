enum WorkStatus {
  fullTime,
  partTime,
}

extension WorkStatusExtension on WorkStatus {
  String get name => toString().split('.').last;

  static WorkStatus fromString(String status) {
    return WorkStatus.values.firstWhere((e) => e.name == status);
  }
}
