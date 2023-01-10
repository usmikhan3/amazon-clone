class UserModel {
  final String uid;
  final String name;
  final String email;
  final String address;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.address,
  });

  Map<String, dynamic> getJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'address': address,
      };

  factory UserModel.getModelFromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
    );
  }
}
