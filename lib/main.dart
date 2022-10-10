import 'package:firebasefirestoreproj1/editscreen.dart';
import 'package:firebasefirestoreproj1/registration_page.dart';
import 'package:firebasefirestoreproj1/tablescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Login_Page.dart';
import 'StudentReg.dart';
import 'identitycardscreen.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: RegistrationPage.id,
      routes: {
        RegistrationPage.id: (context) => const RegistrationPage(),
        LoginPage.id: (context) => const LoginPage(),
        StudentReg.id : (context)=> const StudentReg(),
        identityCardScreen.id: (context) => const identityCardScreen(
            Name: 'name',
            PhoneNumber: 'phonenumber',
            Email: 'email',
            DateOfBirth: 'dob',
            Gender: 'gender',
            Nationality: 'nationality',
            Education: 'education',
            Address: 'address'),

        TableData.id : (context) => TableData(),
        editScreen.editScreenID : (context) => editScreen(id: 'id', name: 'name'),

      },
    );
  }
}
