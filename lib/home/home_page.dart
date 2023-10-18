import 'package:flutter/material.dart';
import 'dart:async';
import 'package:loddge_me/authenticate/add_info.dart';
import 'package:loddge_me/screens/findLodges/find_lodges_screen.dart';
import 'package:loddge_me/screens/account_screen.dart';
import 'package:loddge_me/screens/chats_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loddge_me/screens/reserved_lodges.dart';
import 'package:loddge_me/screens/bookmarks.dart';
import 'package:loddge_me/customIcons/lodge_me_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic email;
  dynamic phoneNumber;
  bool userInfoExists = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? get currentUser => FirebaseAuth.instance.currentUser;

  //check if user info exists
  Future checkUserInfo() async {
    DocumentSnapshot doc =
        await firestore.collection("users").doc(currentUser!.uid).get();
    if (!doc.exists) {
      setState(() {
        userInfoExists = false;
      });
    }
  }

  //get userdetails from firebase
  Future getUserData() async {
    email = currentUser!.email;
    phoneNumber = currentUser!.phoneNumber;
    //debugPrint(email.toString());
  }

  int _selectedIndex = 0;

  @override
  void initState() {
    checkUserInfo();
    getUserData();
    super.initState();
  }

//onItemTapped defined
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pages = [
    const LodgesScreen(),
    const BookmarksScreen(),
    const ReservedLodgesScreen(),
    const ChatsScreen(),
    const AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {});
    if (!userInfoExists) {
      return AddInfo(email, phoneNumber, false);
    } else {
      return Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.black45,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined), label: 'Find'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_outline), label: 'Saved'),
              BottomNavigationBarItem(
                  icon: Icon(Lodge_me.lodge_me, size: 20), label: 'Reserved'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline), label: 'Inbox'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
            ],
          ));
    }
  }
}
