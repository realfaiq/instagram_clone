import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_Model.dart';
import 'package:instagram_clone/providers/user_Provider.dart';
import 'package:instagram_clone/resources/fire_store_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/comment_Card.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({Key? key, required this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['pId'])
            .collection('comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: ((context, index) => CommentCard(
                    snap: (snapshot.data! as dynamic).docs[index].data(),
                  )));
        }),
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.only(left: 16, right: 8),
        child: Row(children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.photoURL),
            radius: 18,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 16, right: 8),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                  hintText: 'Comment as ${user.userName}',
                  border: InputBorder.none),
            ),
          )),
          InkWell(
            onTap: () async {
              await fireStoreMethods().postComments(
                  widget.snap['pId'],
                  _commentController.text,
                  user.uid,
                  user.userName,
                  user.photoURL);
              setState(() {
                _commentController.text = "";
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: const Text(
                'Post',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          )
        ]),
      )),
    );
  }
}
