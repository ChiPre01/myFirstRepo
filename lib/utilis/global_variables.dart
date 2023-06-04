import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoutes/screens/add_post_screen.dart';
import 'package:scoutes/screens/edit_profile.dart';
import 'package:scoutes/screens/feed_screen.dart';
import 'package:scoutes/screens/forgot_password_screen.dart';
import 'package:scoutes/screens/profile_screen.dart';
import 'package:scoutes/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(
    snap: null,
  ),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notif'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
  EditProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),  
];
