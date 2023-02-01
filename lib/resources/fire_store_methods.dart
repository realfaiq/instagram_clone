import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/comment_Model.dart';
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

  //Like Posts
  Future<void> likePosts(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        //Removing the Like in case Already Liked
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        //Adding to Likes Array In case we haven't liked it Already
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  //Post Comments
  Future<void> postComments(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      String commentId = const Uuid().v1();
      if (text.isNotEmpty) {
        Comment comment = Comment(
          profilePic: profilePic,
          name: name,
          uid: uid,
          text: text,
          commentId: commentId,
          datePublished: DateTime.now(),
        );
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set(
              comment.toJSON(),
            );
      } else {
        print('Text is Empty');
      }
    } catch (err) {
      print(err.toString());
    }
  }

  //Deleting the Post
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      print(err.toString());
    }
  }

  //Follow Users
  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
