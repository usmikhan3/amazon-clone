import 'package:amazon_firebase/model/user_model.dart';
import 'package:flutter/material.dart';

class UserDetailProvider with ChangeNotifier {
  UserModel userDetails;

  UserDetailProvider()
      : userDetails = UserModel(
          uid: "",
          name: "Loading",
          email: "",
          address: "Loading",
        );




}
