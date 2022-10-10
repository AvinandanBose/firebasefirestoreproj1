import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class fetchData extends StatefulWidget {
  const fetchData({Key? key}) : super(key: key);

  @override
  State<fetchData> createState() => _fetchDataState();
}

class _fetchDataState extends State<fetchData> {
  bool value1 = false;
  bool value2 = false;
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

              Text('Hobbies:'),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: value1,
                    onChanged: (value) {
                      setState(() {
                        value1 = value!;
                        value2 = false;//Or cancel it to get both selected
                        print(value1);
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
                        value1=false;//Or cancel it to get both selected
                        print(value2);
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

            ],
          ),
        ));
  }
}
