import 'package:flutter/material.dart';
import 'package:loddge_me/providers/authentication_provider.dart';
import 'package:loddge_me/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBy6EaiKmzPKFmfvMpc-O6MMh0Htpp-pxc",
      appId: "1:475622177334:android:25ad8df5d45012f49f7697",
      messagingSenderId:
          "475622177334-sq489js8aq9542t7t6prp7s55jb9lu7j.apps.googleusercontent.com",
      projectId: "lodgeme-9499e",
      storageBucket: "lodgeme-9499e.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (BuildContext context) => AuthProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LodgeMe',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.teal,
        ),
        home: StreamProvider<User?>.value(
            value: FirebaseAuth.instance.authStateChanges(),
            initialData: null,
            child: const Wrapper()),
      ),
    );
  }
}
