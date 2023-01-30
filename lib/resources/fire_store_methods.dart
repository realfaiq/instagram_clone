import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/post_Model.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class fireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Upload Post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profileImage) async {
    String res = 'Some Error Occured';
    try {
      String photoURL =
          await StorageMethods().uploadImageToStorage('Posts', file, true);

      //Creating a Unique Id for Post
      String postId = const Uuid().v1();
      //Create a Post
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          pId: postId,
          datePublished: DateTime.now(),
          postURL: photoURL,
          profileImage: profileImage,
          likes: []);

      _firestore.collection('posts').doc(postId).set(
            post.toJSON(),
          );

      res = 'Success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
