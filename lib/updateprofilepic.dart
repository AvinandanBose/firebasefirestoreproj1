import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasefirestoreproj1/tablescreen.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:google_fonts/google_fonts.dart';

class UpdateProfilePic extends StatefulWidget {
  final String nameprof;

  const UpdateProfilePic({Key? key, required this.nameprof}) : super(key: key);

  @override
  State<UpdateProfilePic> createState() => _UpdateProfilePicState();
}

class _UpdateProfilePicState extends State<UpdateProfilePic> {
  bool isUpdated = false;

  FilePickerResult? result;
  String? filename;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;
  UploadTask? uploadTask;

  bool isSubmitted = false;

  void pickfile() async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null) {
        filename = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());

        print('file_Name: $filename');
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

//FireStoreStorage
  Future uploadFile() async {
    String fileName = pickedFile!.name;
    String filenamenew = fileName.replaceAll(RegExp('[0-9]'), '');
    String path = 'files/$filenamenew'; //Firestore Storage Location
    File file = File(pickedFile!.path!); //Select the file
    Reference ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);// Upload the file
      isUpdated = true;
    });
    TaskSnapshot snapshot = await uploadTask!.whenComplete(() {});
    String urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          'Update ${widget.nameprof}\'s pic',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const TableData();
                }));
              },
              child: const Icon(Icons.arrow_back_ios_rounded),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.20,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  pickfile();
                },
                child: fileToDisplay == null
                    ? CircleAvatar(
                        minRadius: 50,
                        maxRadius: 50,
                        backgroundColor: Colors.blueGrey,
                        child: Icon(
                          Icons.add_photo_alternate,
                          color: Colors.grey,
                          size: MediaQuery.of(context).size.width * 0.20,
                        ),
                      )
                    : CircleAvatar(
                        minRadius: 50,
                        maxRadius: 50,
                        backgroundColor: Colors.purple,
                        backgroundImage: fileToDisplay == null
                            ? null
                            : FileImage(fileToDisplay!),
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
                uploadFile();
                if(isUpdated == true){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.greenAccent,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.purpleAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100),
                      content: Text(
                        'Successfully Pic Updated.',
                        style: GoogleFonts.abel(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                setState(() {
                  isUpdated = false;
                });
              },
              child: const Text('Update Pic'),
            ),
          )
        ],
      ),
    );
  }
}
