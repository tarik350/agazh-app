class UserModel {
  String name;
  // String password;
  String phoneNumber;
  String? role;
  // Additional fields for employee or employer
  String? language;
  String? location;

  UserModel({
    required this.name,
    // required this.password,
    required this.phoneNumber,
    this.role,
    this.language,
    this.location,
  });

  // Convert UserModel to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      // 'password': password,
      'phoneNumber': phoneNumber,
      'role': role,
      'language': language,
      'location': location,
    };
  }

  // Create UserModel from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      // password: map['password'],
      phoneNumber: map['phoneNumber'],
      role: map['role'],
      language: map['language'],
      location: map['location'],
    );
  }
}
