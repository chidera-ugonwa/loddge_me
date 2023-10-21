import 'package:flutter/material.dart';
import 'package:loddge_me/utils/auth.dart';
import 'package:loddge_me/utils/google_sign_in.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AuthProvider _auth = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    ListTile(
                        title: const Text('Profile',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.notifications_outlined,
                                color: Colors.black))),
                    const SizedBox(height: 10),
                    const ListTile(
                      leading: CircleAvatar(),
                      title: Text('Chidera'),
                      subtitle: Text('Show profile'),
                      trailing: Icon(Icons.arrow_forward_outlined,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    SizedBox(
                      height: 150,
                      child: Center(child: Card(child: Container(height: 125))),
                    ),
                    const Divider(),
                    const SizedBox(
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Settings',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ListTile(
                              title: Text('Personal information',
                                  style: TextStyle(fontFamily: 'Raleway')),
                              leading: Icon(Icons.account_circle_outlined,
                                  color: Colors.black54),
                              trailing: Icon(Icons.arrow_forward,
                                  color: Colors.black),
                            ),
                          ],
                        )),
                    const Divider(),
                    const SizedBox(
                        height: 50,
                        child: ListTile(
                            title: Text('Login & security',
                                style: TextStyle(fontFamily: 'Raleway')),
                            leading: Icon(Icons.security_outlined,
                                color: Colors.black54),
                            trailing: Icon(Icons.arrow_forward_outlined,
                                color: Colors.black))),
                    const Divider(),
                    const SizedBox(
                        height: 50,
                        child: ListTile(
                            title: Text('Payments and payouts',
                                style: TextStyle(fontFamily: 'Raleway')),
                            leading: Icon(Icons.payments_outlined,
                                color: Colors.black54),
                            trailing: Icon(Icons.arrow_forward_outlined,
                                color: Colors.black))),
                    const Divider(),
                    const SizedBox(
                        height: 50,
                        child: ListTile(
                            title: Text('Accessibility',
                                style: TextStyle(fontFamily: 'Raleway')),
                            leading: Icon(Icons.settings_outlined,
                                color: Colors.black54),
                            trailing: Icon(Icons.arrow_forward_outlined,
                                color: Colors.black))),
                    const Divider(),
                    const SizedBox(
                        height: 50,
                        child: ListTile(
                            title: Text('Taxes',
                                style: TextStyle(fontFamily: 'Raleway')),
                            leading:
                                Icon(Icons.file_copy, color: Colors.black54),
                            trailing: Icon(Icons.arrow_forward_outlined,
                                color: Colors.black))),
                    const Divider(),
                    const SizedBox(
                        height: 50,
                        child: ListTile(
                            title: Text('Translation',
                                style: TextStyle(fontFamily: 'Raleway')),
                            leading: Icon(Icons.translate_outlined,
                                color: Colors.black54),
                            trailing: Icon(Icons.arrow_forward_outlined,
                                color: Colors.black))),
                    const Divider(),
                    const SizedBox(
                        height: 50,
                        child: ListTile(
                            title: Text('Notifications',
                                style: TextStyle(fontFamily: 'Raleway')),
                            leading: Icon(Icons.notifications_outlined,
                                color: Colors.black54),
                            trailing: Icon(Icons.arrow_forward_outlined,
                                color: Colors.black))),
                    const Divider(),
                    const SizedBox(
                        height: 50,
                        child: ListTile(
                            title: Text('Privacy and sharing',
                                style: TextStyle(fontFamily: 'Raleway')),
                            leading:
                                Icon(Icons.lock_outline, color: Colors.black54),
                            trailing: Icon(Icons.arrow_forward_outlined,
                                color: Color.fromRGBO(0, 0, 0, 1)))),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Support',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 50,
                      child: ListTile(
                          title: Text('Visit the Help Center',
                              style: TextStyle(fontFamily: 'Raleway')),
                          leading: Icon(Icons.help_outline_outlined,
                              color: Colors.black54),
                          trailing: Icon(Icons.arrow_forward_outlined,
                              color: Colors.black)),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 50,
                      child: ListTile(
                          title: Text('Get help with a safety issue',
                              style: TextStyle(fontFamily: 'Raleway')),
                          leading: Icon(Icons.health_and_safety_outlined,
                              color: Colors.black54),
                          trailing: Icon(Icons.arrow_forward_outlined,
                              color: Colors.black)),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 50,
                      child: ListTile(
                          title: Text('Report a neighborhood concern',
                              style: TextStyle(fontFamily: 'Raleway')),
                          leading: Icon(Icons.support_agent_outlined,
                              color: Colors.black54),
                          trailing: Icon(Icons.arrow_forward_outlined,
                              color: Colors.black)),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 50,
                      child: ListTile(
                          title: Text('Give us feedback',
                              style: TextStyle(fontFamily: 'Raleway')),
                          leading: Icon(Icons.edit, color: Colors.black54),
                          trailing: Icon(Icons.arrow_forward_outlined,
                              color: Colors.black)),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Legal',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 50,
                      child: ListTile(
                          title: Text('Terms of Service',
                              style: TextStyle(fontFamily: 'Raleway')),
                          leading: Icon(Icons.menu_book_outlined,
                              color: Colors.black54),
                          trailing: Icon(Icons.arrow_forward_outlined,
                              color: Colors.black)),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 50,
                      child: ListTile(
                          title: Text('Privacy Policy',
                              style: TextStyle(fontFamily: 'Raleway')),
                          leading: Icon(Icons.menu_book_outlined,
                              color: Colors.black54),
                          trailing: Icon(Icons.arrow_forward_outlined,
                              color: Colors.black)),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 50,
                      child: ListTile(
                          title: Text('Open source licenses',
                              style: TextStyle(fontFamily: 'Raleway')),
                          leading: Icon(Icons.menu_book_outlined,
                              color: Colors.black54),
                          trailing: Icon(Icons.arrow_forward_outlined,
                              color: Colors.black)),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        _auth.signOut();
                        SignInWithGoogle.disconnect();
                      },
                      child: const Text('Log out',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              decoration: TextDecoration.underline)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
