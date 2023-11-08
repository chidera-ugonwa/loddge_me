import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:loddge_me/screens/chats/chat_page.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'Inbox',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  _buildUserList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //build a list of chats
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('chats')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: JumpingDots(
              color: Colors.black,
              radius: 6,
              numberOfDots: 3,
              innerPadding: 2.0,
              verticalOffset: 10,
              animationDuration: const Duration(milliseconds: 300),
            ));
          }
          return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs
                  .map<Widget>((doc) => _buildUserListItem(doc))
                  .toList());
        });
  }

  //build individual user list items
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey,
      ))),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          child: const Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
        subtitle: const Text('Student at Unizik'),
        title: Text(data['displayName']),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => ChatPage(
                        receiverDisplayName: data['displayName'],
                        receiverUserID: data['uid'],
                      ))));
        },
      ),
    );
  }
}
