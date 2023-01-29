import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoURL;
  final String userName;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.photoURL,
    required this.userName,
    required this.bio,
    required this.followers,
    required this.following,
  });

  //Converts and returns the data to object So we don't have to write it multiple times
  Map<String, dynamic> toJSON() => {
        "username": userName,
        "uid": uid,
        "email": email,
        "photoURL": photoURL,
        "bio": bio,
        "followers": followers,
        "following": following
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return User(
        userName: snapShot['username'],
        uid: snapShot['uid'],
        email: snapShot['email'],
        photoURL: snapShot['photoURL'],
        bio: snapShot['bio'],
        followers: snapShot['followers'],
        following: snapShot['following']);
  }
}
