import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Sign Up User
  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Some error Occured';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //Register the User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //Add User to the Database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': userName,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
        });
        res = 'Success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
