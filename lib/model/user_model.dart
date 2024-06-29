class UserModel {
  String designation;
  String email;
  String imageUrl;
  String name;
  String registrationDate;
  String uid;

  UserModel({
    required this.designation,
    required this.email,
    required this.imageUrl,
    required this.name,
    required this.registrationDate,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      designation: json['designation'],
      email: json['email'],
      imageUrl: json['image_url'],
      name: json['name'],
      registrationDate: json['registration_date'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'designation': designation,
      'email': email,
      'image_url': imageUrl,
      'name': name,
      'registration_date': registrationDate,
      'uid': uid,
    };
  }
}
