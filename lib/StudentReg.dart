import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentReg extends StatefulWidget {
  const StudentReg({Key? key}) : super(key: key);

  @override
  State<StudentReg> createState() => _StudentRegState();
}

class _StudentRegState extends State<StudentReg> {
  int a = 0;

  Future<dynamic> addGender(Map<String, String> messageMap) async {

    return await FirebaseFirestore.instance
        .collection("Gender$a")
        .doc("Gender$a")
        .set(messageMap)
        .catchError((e) {
      print(e);
      throw ' No data has been set';
    });
  }

  String selectedText = "";
  TextEditingController genderEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio Button Flutter Firebase'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Expanded(
                  child: Text(
                    "Gender",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: "Male", //Unique
                      groupValue: selectedText, //Same
                      onChanged: (value) {
                        setState(() {
                          selectedText = value!;
                          genderEditingController.text = value;
                          if (selectedText != null) {
                            genderEditingController.text = value;
                            print(genderEditingController.text);
                          }
                        });
                      },
                      fillColor: MaterialStateProperty.all(Colors.purple),
                    ),
                    const Text(
                      "Male",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    Radio(
                      value: "Female", //Unique
                      groupValue: selectedText, //Same
                      onChanged: (value) {
                        setState(() {
                          selectedText = value!;
                          if (selectedText != null) {
                            genderEditingController.text = value;
                            print(genderEditingController.text);
                          }
                        });
                      },
                      fillColor: MaterialStateProperty.all(Colors.purple),
                    ),
                    const Text(
                      "Female",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Material(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(32),
            child: MaterialButton(
              minWidth: 200.0,
              height: 42.0,
              onPressed: () {
                Map<String, String> messagemap = {
                  "Gender": genderEditingController.text
                };

                addGender(messagemap);
                setState(() {
                  genderEditingController.text = "";
                  selectedText = "";
                  a=a+1;
                });
              },
              child: const Text(
                'Enter Data',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
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
                setState(() {
                  a=0;
                });
              },
              child: const Text(
                'RESET DOC VALUE OF FIREBASE',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Text(pickedFile!.name)
