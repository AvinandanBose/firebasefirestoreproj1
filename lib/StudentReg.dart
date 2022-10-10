import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasefirestoreproj1/tablescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentReg extends StatefulWidget {
  const StudentReg({Key? key}) : super(key: key);

  @override
  State<StudentReg> createState() => _StudentRegState();
}

class _StudentRegState extends State<StudentReg> {
  int a = 0;
  String? extractTheInteger;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController nationalityTextEditingController =
      TextEditingController();
  TextEditingController educationTextEditingController =
      TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController date = TextEditingController();

  String setEducationList = "Set Your Education";
  bool value1 = false;
  bool value2 = false;
  String selectedGender = "";
  bool isGenderOther = false;
  bool isNationality = false;
  final formKey = GlobalKey<FormState>();

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
    String path = 'files/${pickedFile!.name}'; //Firestore Storage Location
    File file = File(pickedFile!.path!); //Select the file
    Reference ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file); // Upload the file
    });
    TaskSnapshot snapshot = await uploadTask!.whenComplete(() {});
    String urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');
  }

  //Doc ID Increment
  List<String> docIds = [];
  Future getDocIds() async {
    await FirebaseFirestore.instance.collection('students').get().then(
          (snapshot) => snapshot.docs.forEach((element) {
            print(element.reference);
            docIds.add(element.reference.id);
          }),
        );
  }

  Future<dynamic> studentsData(Map<String, String> messageMap) async {
    return await FirebaseFirestore.instance
        .collection("students")
        .doc("stu$a")
        .set(messageMap)
        .catchError((e) {
      print(e);
      throw ' No data has been set';
    });
  }

  List<String> educationList = [
    'Set Your Education',
    'Post Graduation',
    'Graduation',
    'Diploma',
    'XII',
    'XI',
    'X',
    'IX',
    'VIII',
    'VII',
    'VI',
    'V',
    'IV',
    'III',
    'II',
    'I',
  ];
  DropdownButtonHideUnderline getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String education in educationList) {
      var newItem = DropdownMenuItem(
        child: Text(education),
        value: education,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: setEducationList,
        items: dropdownItems, //getDropDownItem()→dropdownItems
        onChanged: (value) {
          setState(() {
            setEducationList = value!;
            educationTextEditingController.text = setEducationList;
            print(educationTextEditingController.text);
          });
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocIds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Identity Card',
          style: GoogleFonts.alike(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.7,
            image: AssetImage(
              'assets/images/Admissions_gris.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: <Widget>[
                Center(
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
                const SizedBox(
                  height: 20.0,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: TextFormField(
                          controller: nameTextEditingController,
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
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.purpleAccent,
                            ),
                            hintText: 'Students Name',
                            labelText: 'Name',
                            labelStyle:
                                const TextStyle(color: Colors.redAccent),
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.0),
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
                          controller: phoneNumberTextEditingController,
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
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone,
                                color: Colors.purpleAccent),
                            hintText: 'Students Phone Number',
                            labelText: 'Phone Number',
                            labelStyle:
                                const TextStyle(color: Colors.redAccent),
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.0),
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
                      //___________PHONE NUMBER__________________
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: TextFormField(
                          controller: emailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? msg) {
                            if (msg?.isEmpty == true) {
                              return "Please Enter The Phone Number";
                            }
                            if ((msg?.length)! < 10) {
                              return "Phone Number Must Be 10 Digit";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email,
                                color: Colors.purpleAccent),
                            hintText: 'Students Email Address',
                            labelText: 'Email',
                            labelStyle:
                                const TextStyle(color: Colors.redAccent),
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.0),
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
                      //___________DATE__________________
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: TextFormField(
                          controller: date,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? msg) {
                            if (msg?.isEmpty == true) {
                              return "Enter Your DOB";
                            }
                            return null;
                          },
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
                                    date.text =
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
                            labelText: 'DOB',
                            labelStyle:
                                const TextStyle(color: Colors.redAccent),
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.0),
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
                      //___________Radio__________________
                      isGenderOther
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: TextFormField(
                                controller: genderTextEditingController,
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
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isGenderOther = false;
                                          selectedGender = "";
                                        });
                                      },
                                      icon: const Icon(Icons.clear)),
                                  hintText: 'Enter Your Gender',
                                  labelText: 'OTHER GENDER',
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
                                        color: Colors.lightBlueAccent,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: Row(
                                children: <Widget>[
                                  const Text(
                                    "Gender :",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Radio(
                                        value: "Male", //Unique
                                        groupValue: selectedGender, //Same
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value!;
                                            genderTextEditingController.text =
                                                value;
                                            print(genderTextEditingController
                                                .text);
                                          });
                                        },
                                        fillColor: MaterialStateProperty.all(
                                            Colors.purple),
                                      ),
                                      const Text(
                                        "Male",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      Radio(
                                        value: "Female", //Unique
                                        groupValue: selectedGender, //Same
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value!;
                                            genderTextEditingController.text =
                                                value;
                                            print(genderTextEditingController
                                                .text);
                                          });
                                        },
                                        fillColor: MaterialStateProperty.all(
                                            Colors.purple),
                                      ),
                                      const Text(
                                        "Female",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      Radio(
                                        value: "Other", //Unique
                                        groupValue: selectedGender, //Same
                                        onChanged: (value) {
                                          setState(() {
                                            isGenderOther = true;
                                            genderTextEditingController.clear();
                                          });
                                        },
                                        fillColor: MaterialStateProperty.all(
                                            Colors.purple),
                                      ),
                                      const Text(
                                        "Other",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      const Divider(
                        height: 20,
                        thickness: 1.0,
                      ),
                      //___________Checkbox__________________
                      isNationality
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: TextFormField(
                                controller: nationalityTextEditingController,
                                keyboardType: TextInputType.text,
                                validator: (String? msg) {
                                  if (msg?.isEmpty == true) {
                                    return "Enter Your Nationality";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(CupertinoIcons.globe,
                                      color: Colors.purpleAccent),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isNationality = false;
                                          value2 = false;
                                        });
                                      },
                                      icon: const Icon(Icons.clear)),
                                  hintText: 'Enter Your Nationality',
                                  labelText: 'OTHER NATIONALITY',
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
                                        color: Colors.lightBlueAccent,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: Row(
                                children: <Widget>[
                                  const Text(
                                    "Nationality :",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        activeColor: Colors.redAccent,
                                        checkColor: Colors.black87,
                                        value: value1,
                                        onChanged: (value) {
                                          setState(() {
                                            value1 = value!;
                                            nationalityTextEditingController
                                                .text = "Indian";
                                            print(value1);
                                          });
                                        },
                                      ),
                                      const Text(
                                        'Indian',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      Checkbox(
                                        activeColor: Colors.redAccent,
                                        checkColor: Colors.black87,
                                        value: value2,
                                        onChanged: (value) {
                                          setState(() {
                                            isNationality = true;
                                            nationalityTextEditingController
                                                .clear();
                                          });
                                        },
                                      ),
                                      const Text(
                                        'Others',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      const Divider(
                        height: 20,
                        thickness: 1.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Row(
                          children: <Widget>[
                            const Text(
                              "Education :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            getDropdownButton(),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: TextFormField(
                          controller: addressTextEditingController,
                          keyboardType: TextInputType.text,
                          validator: (String? msg) {
                            if (msg?.isEmpty == true) {
                              return "Please Enter the Address";
                            }
                            if ((msg?.length)! < 3) {
                              return "Name is less than 3 character";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.home,
                                color: Colors.purpleAccent),
                            hintText: 'Enter Your Address',
                            labelText: 'Address',
                            labelStyle:
                                const TextStyle(color: Colors.redAccent),
                            hintStyle: const TextStyle(
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1.0),
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
                        height: 50,
                        child: Material(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(32),
                          child: MaterialButton(
                            minWidth: 200.0,
                            height: 42.0,
                            onPressed: () async {
                              if (formKey.currentState?.validate() == true) {
                                uploadFile();

                                await getDocIds();
                                if (getDocIds() == null) {
                                  docIds.clear();
                                }

                                Map<String, String> messagemap = {
                                  "Name": nameTextEditingController.text,
                                  "Phone":
                                      phoneNumberTextEditingController.text,
                                  "Email": emailTextEditingController.text,
                                  "DOB": date.text,
                                  "Gender": genderTextEditingController.text,
                                  "Nationality":
                                      nationalityTextEditingController.text,
                                  "Education":
                                      educationTextEditingController.text,
                                  "Address": addressTextEditingController.text,
                                };
                                setState(() {
                                  if (docIds.isEmpty == true) {
                                    studentsData(messagemap);
                                  } else {
                                    extractTheInteger = docIds.last
                                        .replaceAll(RegExp(r'[^0-9]'), '');
                                    a = int.parse(extractTheInteger!) + 1;
                                    print(a);
                                    studentsData(messagemap);
                                  }
                                });
                                setState(() {
                                  isSubmitted = true;
                                });
                                if (isSubmitted == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: Colors.greenAccent,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: Colors.purpleAccent,
                                      duration: const Duration(seconds: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 100),
                                      content: Text(
                                        'Successfully Data Submitted',
                                        style: GoogleFonts.abel(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: Colors.greenAccent,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: Colors.purpleAccent,
                                      duration: const Duration(seconds: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 100),
                                      content: Text(
                                        'Data  Not Submitted , ERROR!',
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
                                  isSubmitted == false;
                                });
                              } else {
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
                                      'Please Provide Valid Details.',
                                      style: GoogleFonts.abel(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 50,
                        child: Material(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(32),
                          child: MaterialButton(
                            minWidth: 200.0,
                            height: 42.0,
                            onPressed: () {
                              nameTextEditingController.clear();
                              phoneNumberTextEditingController.clear();
                              emailTextEditingController.clear();
                              genderTextEditingController.clear();
                              nationalityTextEditingController.clear();
                              educationTextEditingController.clear();
                              addressTextEditingController.clear();
                              date.clear();
                              setState(() {
                                fileToDisplay = null;
                                selectedGender = " ";
                                value1 = false;
                                value2 = false;
                                setEducationList = "Set Your Education";
                                isGenderOther = false;
                                isNationality = false;
                              });
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
                                    'Sucessfully Reset.',
                                    style: GoogleFonts.abel(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'RESET',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 50,
                        child: Material(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(32),
                          child: MaterialButton(
                            minWidth: 200.0,
                            height: 42.0,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return const TableData();
                                }),
                              );
                            },
                            child: Text('Fetch Data as Table',
                                style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
