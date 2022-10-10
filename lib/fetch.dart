import 'package:flutter/material.dart';

class fetchData extends StatefulWidget {
  const fetchData({Key? key}) : super(key: key);

  @override
  State<fetchData> createState() => _fetchDataState();
}

class _fetchDataState extends State<fetchData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation of Text Form Field'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const Text('Address'),
          TextFormField(
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.greenAccent,
                  width: 5.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlueAccent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
