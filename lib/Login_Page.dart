import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasefirestoreproj1/StudentReg.dart';
import 'package:firebasefirestoreproj1/registration_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth authMethods = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await authMethods
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for that email");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Log In Page',
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
                    'Sign In',
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
                      obscureText: true,
                      validator: (String? value) {
                        return (value != null && 6 < value.length)
                            ? null
                            : "Please provide 6+ characters";
                      },
                      controller: passwordTextEditingController,
                      decoration: const InputDecoration(
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
                onPressed: () async{
                  User? user = await loginUsingEmailPassword(email: emailTextEditingController.text, password: passwordTextEditingController.text, context: context) ;
                  print(user);
                  if(user!=null){
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StudentReg()));
                    });

                  }

                },
                child: const Text(
                  'Log In',
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
                  "Don't have account?",
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
                          builder: (context) => RegistrationPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Register Now",
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
