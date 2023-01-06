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

}
