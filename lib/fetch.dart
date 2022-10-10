import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StudentRegBuild extends StatefulWidget {
  const StudentRegBuild({Key? key}) : super(key: key);

  @override
  State<StudentRegBuild> createState() => _StudentRegBuildState();
}

class _StudentRegBuildState extends State<StudentRegBuild> {
  String? downloadurl;

  Future<void> downloadURL() async {
    try {
      downloadurl = await FirebaseStorage.instance
          .ref()
          .child('files/51363.jpg')
          .getDownloadURL();
      print(downloadurl);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    downloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Fetch Data from FireStore',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: downloadURL(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something has Error');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Image.network('$downloadurl');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
