import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/profile_Screen.dart';
import '../screens/add_Post_Screen.dart';
import '../screens/feed_Screen.dart';
import '../screens/search_screen.dart';

const webScreen = 600;

final homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text('Notification'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
