import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasefirestoreproj1/tablescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class editScreen extends StatefulWidget {
  static const String editScreenID = 'Identity_Screen';
  String id;
  String name;
  editScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<editScreen> createState() => _editScreenState();
}

class _editScreenState extends State<editScreen> {
  FilePickerResult? result;
  String? filename;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;
  UploadTask? uploadTask;
  String? getUrlDownLoadLink;

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
      uploadTask = ref.putFile(file); // Upload the file
    });
    TaskSnapshot snapshot = await uploadTask!.whenComplete(() {});
    String urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');
    return urlDownload.toString();
  }

  bool isEditing = false;
  final formKey = GlobalKey<FormState>();

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetailsById(
      String getId) async {
    return await FirebaseFirestore.instance
        .collection("students")
        .doc(getId)
        .get();
  }

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> updateUser(id, name, phone, email, dob, gender, nationality,
      education, address, photoUrl) {
    setState(() {
      isEditing = true;
    });
    return students.doc(id).update({
      'Name': name,
      'Phone': phone,
      'Email': email,
      'DOB': dob,
      'Gender': gender,
      'Nationality': nationality,
      'Education': education,
      'Address': address,
      'photoUrl': photoUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Edit ${widget.name}\'s Data'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TableData.id);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: getUserDetailsById(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('Something Went Wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  var name = snapshot.data!.data()!['Name'];
                  var phone = snapshot.data!.data()!['Phone'];
                  var email = snapshot.data!.data()!['Email'];
                  var dob = snapshot.data!.data()!['DOB'];
                  var gender = snapshot.data!.data()!['Gender'];
                  var nationality = snapshot.data!.data()!['Nationality'];
                  var education = snapshot.data!.data()!['Education'];
                  var address = snapshot.data!.data()!['Address'];
                  var photoUrl = snapshot.data!.data()!['photoUrl'];

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
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
                                      backgroundImage: NetworkImage(photoUrl),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: TextFormField(
                            initialValue: name,
                            keyboardType: TextInputType.text,
                            validator: (String? msg) {
                              if (msg?.isEmpty == true) {
                                return "Please Enter the Name";
                              }
                              if ((msg?.length)! < 3) {
                                return "Name is less than 3 character";
                              }
                              return null;
                            },
                            onChanged: (value) => name = value,
                            //onChanged: (value) { name = value;},
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.purpleAccent,
                              ),
                              hintText: 'Update Name',
                              labelText: 'Edit Name',
                              labelStyle:
                                  const TextStyle(color: Colors.redAccent),
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: TextFormField(
                            initialValue: phone,
                            keyboardType: TextInputType.number,
                            validator: (String? msg) {
                              if (msg?.isEmpty == true) {
                                return "Please Enter The Phone Number";
                              }
                              if ((msg?.length)! < 10) {
                                return "Phone Number Must Be 10 Digit";
                              }
                              return null;
                            },
                            onChanged: (value) => phone = value,
                            //onChanged: (value) { phone = value;},
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone,
                                  color: Colors.purpleAccent),
                              hintText: 'Update Phone',
                              labelText: 'Edit Phone',
                              labelStyle:
                                  const TextStyle(color: Colors.redAccent),
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: TextFormField(
                            initialValue: email,
                            keyboardType: TextInputType.emailAddress,
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
                            onChanged: (value) => email = value,
                            //onChanged: (value) { email = value;},
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email,
                                  color: Colors.purpleAccent),
                              hintText: 'Update Email',
                              labelText: 'Edit Email',
                              labelStyle:
                                  const TextStyle(color: Colors.redAccent),
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: TextFormField(
                            initialValue: dob,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? msg) {
                              if (msg?.isEmpty == true) {
                                return "Enter Your DOB";
                              }
                              return null;
                            },
                            onChanged: (value) => dob = value,
                            //onChanged: (value) { dob = value;},
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                onPressed: () async {
                                  DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  );
                                  if (newDate == null) {
                                    return;
                                  }
                                  if (newDate != null) {
                                    setState(() {
                                      dob =
                                          DateFormat('dd-M-y').format(newDate);
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.green,
                                ),
                              ),
                              hintText: 'DD-MM-yyyy',
                              labelText: 'EDIT DOB',
                              labelStyle:
                                  const TextStyle(color: Colors.redAccent),
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: TextFormField(
                            initialValue: gender,
                            keyboardType: TextInputType.text,
                            validator: (String? msg) {
                              if (msg?.isEmpty == true) {
                                return "Please Enter Gender";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.male,
                                  color: Colors.purpleAccent),
                              hintText: 'Update Gender',
                              labelText: 'EDIT GENDER',
                              labelStyle:
                                  const TextStyle(color: Colors.redAccent),
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: TextFormField(
                            initialValue: nationality,
                            keyboardType: TextInputType.text,
                            validator: (String? msg) {
                              if (msg?.isEmpty == true) {
                                return "Enter Your Nationality";
                              }
                              return null;
                            },
                            onChanged: (value) => nationality = value,
                            //onChanged: (value) { nationality = value;},
                            decoration: InputDecoration(
                              prefixIcon: const Icon(CupertinoIcons.globe,
                                  color: Colors.purpleAccent),
                              hintText: 'Update Nationality',
                              labelText: 'EDIT NATIONALITY',
                              labelStyle:
                                  const TextStyle(color: Colors.redAccent),
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: TextFormField(
                            initialValue: education,
                            keyboardType: TextInputType.text,
                            validator: (String? msg) {
                              if (msg?.isEmpty == true) {
                                return "Enter Your Education Details";
                              }
                              return null;
                            },
                            onChanged: (value) => education = value,
                            //onChanged: (value) { education = value;},
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.menu_book_rounded,
                                  color: Colors.purpleAccent),
                              hintText: 'Update Education',
                              labelText: 'EDIT EDUCATION',
                              labelStyle:
                                  const TextStyle(color: Colors.redAccent),
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: TextFormField(
                            initialValue: address,
                            keyboardType: TextInputType.text,
                            validator: (String? msg) {
                              if (msg?.isEmpty == true) {
                                return "Please Enter the Address";
                              }
                              if ((msg?.length)! < 3) {
                                return "Address is less than 3 character";
                              }
                              return null;
                            },
                            onChanged: (value) => address = value,
                            //onChanged: (value) { address = value;},
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.home,
                                  color: Colors.purpleAccent),
                              hintText: 'UPDATE ADDRESS',
                              labelText: 'EDIT ADDRESS',
                              labelStyle:
                                  const TextStyle(color: Colors.redAccent),
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
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
                            onPressed: () async {
                              getUrlDownLoadLink = await uploadFile();

                              if (formKey.currentState?.validate() == true) {
                                updateUser(
                                    widget.id,
                                    name,
                                    phone,
                                    email,
                                    dob,
                                    gender,
                                    nationality,
                                    education,
                                    address,
                                    getUrlDownLoadLink);
                              }
                              if (isEditing == true) {
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
                                      'Successfully Updated!',
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
                                isEditing = false;
                              });
                              Future.delayed(Duration(seconds: 5), () {
                                Navigator.pushNamed(context, TableData.id);
                              });
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
