import 'package:amazon_firebase/model/user_model.dart';
import 'package:amazon_firebase/resources/cloudfirestore_methods.dart';
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


  Future getData() async{
    userDetails = await CloudFirestoreMethods().getUserDetails();
    notifyListeners();
  }




}
