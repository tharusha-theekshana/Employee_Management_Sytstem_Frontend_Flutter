class Employee {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String birthday;
  final String? profilePicturePath;
  final int? currentAgeInDays;

  Employee({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthday,
    this.profilePicturePath,
    this.currentAgeInDays,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      birthday: json['birthday'],
      profilePicturePath: json['profilePicturePath'],
      currentAgeInDays: json['currentAgeInDays'],
    );
  }
}
