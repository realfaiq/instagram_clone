import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String pId;
  final datePublished;
  final String postURL;
  final String profileImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.pId,
    required this.datePublished,
    required this.postURL,
    required this.profileImage,
    required this.likes,
  });

  //Converts and returns the data to object So we don't have to write it multiple times
  Map<String, dynamic> toJSON() => {
        "description": description,
        "uid": uid,
        "username": username,
        "pId": pId,
        "datePublished": datePublished,
        "postURL": postURL,
        "profileImage": profileImage,
        "likes": likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapShot['description'],
      uid: snapShot['uid'],
      username: snapShot['username'],
      pId: snapShot['pId'],
      datePublished: snapShot['datePublished'],
      postURL: snapShot['postURL'],
      profileImage: snapShot['profileImage'],
      likes: snapShot['likes'],
    );
  }
}
