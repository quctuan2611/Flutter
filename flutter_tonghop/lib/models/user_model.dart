class UserModel {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phone;
  final String birthDate;
  final String gender;
  final String image;
  final String address;
  final String city;
  final String companyName;
  final String jobTitle;
  final String university;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.image,
    required this.address,
    required this.city,
    required this.companyName,
    required this.jobTitle,
    required this.university,
  });

  // Chuyển đổi từ JSON nhận được từ API sang Object Flutter
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      birthDate: json['birthDate'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'] ?? '',
      address: json['address']?['address'] ?? '',
      city: json['address']?['city'] ?? '',
      companyName: json['company']?['name'] ?? '',
      jobTitle: json['company']?['title'] ?? '',
      university: json['university'] ?? '',
    );
  }
}