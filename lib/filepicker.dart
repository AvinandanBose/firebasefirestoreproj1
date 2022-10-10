import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerFirst extends StatefulWidget {
  const FilePickerFirst({Key? key}) : super(key: key);

  @override
  State<FilePickerFirst> createState() => _FilePickerFirstState();
}

class _FilePickerFirstState extends State<FilePickerFirst> {
  FilePickerResult?  result;
  String? filename;
  PlatformFile? pickedFile;
  bool isloading = false;
  File? fileToDisplay;

  void pickfile() async{
    try{
      setState(() {
        isloading  = true;
      });

      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if(result!= null){
        filename = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());

        print('file_Name: $filename');
      }
      setState(() {
        isloading = false;
      });

    }catch (e){
      print(e);

    }
  }




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
          Center(
            child: isloading ?CircularProgressIndicator() : TextButton(onPressed: (){
              pickfile();
            }, child: Text('PickFile')),
          ),
          if(pickedFile!=null)
            SizedBox(
              height: 300,
              width: 400,
              child: Image.file(fileToDisplay!),
            )

        ],
      ),
    );
  }
}

//Text(pickedFile!.name)
