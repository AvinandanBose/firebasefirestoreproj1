import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'checkbox_fetch.dart';

class fetchData extends StatefulWidget {
  const fetchData({Key? key}) : super(key: key);

  @override
  State<fetchData> createState() => _fetchDataState();
}

class _fetchDataState extends State<fetchData> {
  int a = 0;
  bool value1 = false;
  bool value2 = false;
  TextEditingController textEditingController = TextEditingController();
  Future<dynamic> addGender(Map<String, String> messageMap) async {
    return await FirebaseFirestore.instance
        .collection("Hobbies")
        .doc("Hobbies$a")
        .set(messageMap)
        .catchError((e) {
      print(e);
      throw ' No data has been set';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation of Check Boxes'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Hobbies:'),
            Row(
              children: <Widget>[
                Checkbox(
                  value: value1,
                  onChanged: (value) {
                    setState(() {
                      value1 = value!;
                      value2 = false;
                      if (value1 == true) {
                        textEditingController.text = 'Singing';
                        print(textEditingController.text);
                      }
                    });
                  },
                ),
                const Text(
                  'Singing',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Checkbox(
                  value: value2,
                  onChanged: (value) {
                    setState(() {
                      value2 = value!;
                      value1 = false; //Or cancel it to get both selected
                      if (value2 == true) {
                        textEditingController.text = 'Dancing';
                        print(textEditingController.text);
                      }
                    });
                  },
                ),
                const Text(
                  'Dancing',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Material(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(32),
              child: MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                onPressed: () {
                  Map<String, String> messagemap = {
                    "Hobby": textEditingController.text
                  };

                  addGender(messagemap);
                  setState(() {
                    textEditingController.text = "";
                    value1 = false;
                    value2 = false;
                    a = a + 1;
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const CheckBox_Fetch()));
                  
                },
                child: const Text(
                  'Fetch Data',
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
                    a = 0;
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
      ),
    );
  }
}
