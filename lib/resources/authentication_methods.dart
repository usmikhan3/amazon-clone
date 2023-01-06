import 'package:amazon_firebase/model/user_model.dart';
import 'package:amazon_firebase/resources/cloudfirestore_methods.dart';
import 'package:amazon_firebase/utils/constants.dart';
import 'package:amazon_firebase/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CloudFirestoreMethods cloudFirestoreMethods = CloudFirestoreMethods();
  Future<String> signUpUser({
    required String name,
    required String address,
    required String email,
    required String password,
  }) async {
    name.trim();
    address.trim();
    password.trim();
    email.trim();

    String output = "Something went wrong";
    if (name != "" && address != "" && email != "" && password != "") {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        UserModel userModel = UserModel(
          uid: _auth.currentUser!.uid,
          name: name,
          email: email,
          address: address,
        );

        cloudFirestoreMethods.uploadUserDataToDatabase(
          userModel: userModel,
        );

        output = successRegisterMessage;
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the field";
    }
    return output;
  }

  Future<String> sigInUser({
    required String email,
    required String password,
  }) async {
    password.trim();
    email.trim();

    String output = "Something went wrong";
    if (email != "" && password != "") {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        output = successLoginMessage;
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the field";
    }
    return output;
  }
}
