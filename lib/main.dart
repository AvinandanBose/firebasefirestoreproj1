import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'checkbox_fetch.dart';
import 'fetch.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: const FirebaseOptions
    //   (apiKey: "AIzaSyBFuwoL_gF3fuERJmCSLBWAo1SoqP2Omys",
    //     appId: "1:453604555763:web:35800392d33abbdae93086",
    //     messagingSenderId:"453604555763",
    //     projectId: "studentreg-c47ca",)
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const fetchData(),
    );
  }
}
