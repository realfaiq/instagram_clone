import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String profilePic;
  final String name;
  final String uid;
  final String text;
  final String commentId;
  final datePublished;

  const Comment(
      {required this.profilePic,
      required this.name,
      required this.uid,
      required this.text,
      required this.commentId,
      required this.datePublished});

  //Converts and returns the data to object So we don't have to write it multiple times
  Map<String, dynamic> toJSON() => {
        "profilePic": profilePic,
        "name": name,
        "uid": uid,
        "text": text,
        "commentId": commentId,
        "datePublished": datePublished,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return Comment(
      profilePic: snapShot['profilePic'],
      name: snapShot['name'],
      uid: snapShot['uid'],
      text: snapShot['text'],
      commentId: snapShot['commentId'],
      datePublished: snapShot['datePublished'],
    );
  }
}
