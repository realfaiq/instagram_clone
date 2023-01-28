import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

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
        print(cred.user!.uid);

        //Getting PhotoURL of the User
        String photoURL = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        //Add User to the Database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': userName,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoURL': photoURL,
        });
        res = 'Success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The Email is badly Formatted';
      } else if (err.code == 'weak-password') {
        res = 'Your Password is too weak';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
