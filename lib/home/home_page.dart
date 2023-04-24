import 'package:flutter/material.dart';
import 'package:loddge_me/screens/find_lodges_screen.dart';
import 'package:loddge_me/screens/account_screen.dart';
import 'package:loddge_me/screens/chats_screen.dart';
import 'package:loddge_me/screens/reserved_lodges.dart';
import 'package:loddge_me/screens/bookmarks.dart';
import 'package:loddge_me/customIcons/lodge_me_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
