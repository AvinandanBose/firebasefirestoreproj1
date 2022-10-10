import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StudentReg extends StatefulWidget {
  const StudentReg({Key? key}) : super(key: key);

  @override
  State<StudentReg> createState() => _StudentRegState();
}

class _StudentRegState extends State<StudentReg> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    String path = 'files/${pickedFile!.name}'; //Firestore Storage Location
    File file = File(pickedFile!.path!); //Select the file
    Reference ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);// Upload the file


    });
//The Whole Condition may look Like:

    //UploadTask uploadTask = FirebaseStorage.instance.ref().child('files/${pickedFile!.name}').putFile(File(pickedFile!.path!));
    //Here it is shortened

    TaskSnapshot snapshot = await uploadTask!.whenComplete(() {});
    String urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');
  }

  Widget buildprogress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot){
        if(snapshot.hasData){
          final data = snapshot.data;
          int? byteTransferred = data?.bytesTransferred;
          int? totalBytes =  data?.totalBytes;
          double progress = byteTransferred! / totalBytes!;
          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text(
                    '${(100*progress).round()}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),

                  ),
                )
              ],
            ),
          );

        }
        else{
          return const SizedBox(height: 50);
        }

      });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Student Register'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (pickedFile != null)
            Expanded(
              child: Container(
                color: Colors.blue[100],
                child: Image.file(
                  File(pickedFile!.path!),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              selectFile();
            },
            child: Text('Select File'),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              uploadFile();
            },
            child: Text('Upload File'),
          ),
          const SizedBox(height: 32),
          buildprogress(),

        ],
      ),
    );

  }
}

//Text(pickedFile!.name)


