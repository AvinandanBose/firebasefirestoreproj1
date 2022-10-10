import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login_Page.dart';
import 'StudentReg.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  FirebaseAuth authMethods = FirebaseAuth.instance;

  bool isObsecuretext = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Admin Panel - Registration',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.yellow),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: SizedBox(
                height: 50,
                width: 300,
                child: Center(
                  child: Text(
                    'Registration',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value != null && value.isEmpty == true) {
                          return "Please fill up the blank";
                        } else if (value != null && value.length <= 3) {
                          return "username must be greater than 3";
                        }
                        return null;
                      },
                      controller: userNameTextEditingController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black45, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value != null && value.isEmpty == true) {
                          return "Please Enter An Email";
                        } else {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)
                              ? null
                              : "Enter correct email";
                        }
                      },
                      controller: emailTextEditingController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'email',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black45, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextFormField(
                      obscureText: isObsecuretext,
                      validator: (String? value) {
                        return (value != null && 6 < value.length)
                            ? null
                            : "Please provide 6+ characters";
                      },
                      controller: passwordTextEditingController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key_sharp),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObsecuretext = !isObsecuretext;
                              });
                            },
                            icon: isObsecuretext
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black45, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Material(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(32),
              child: MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                onPressed: () {
                  if (formKey.currentState?.validate() == true) {
                    authMethods
                        .createUserWithEmailAndPassword(
                            email: emailTextEditingController.text,
                            password: passwordTextEditingController.text)
                        .then(
                          (value) => print(value),
                        );

                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StudentReg()));
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.purpleAccent,
                        duration: const Duration(seconds: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        content: Text(
                          'Please Provide Valid Details.',
                          style: GoogleFonts.abel(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "LogIn Now",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
