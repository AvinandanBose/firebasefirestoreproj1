import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasefirestoreproj1/tablescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class identityCardScreen extends StatefulWidget {
  static const String id = 'Identity_Screen';
  final String Name;
  final String PhoneNumber;
  final String Email;
  final String DateOfBirth;
  final String Gender;
  final String Nationality;
  final String Education;
  final String Address;
  const identityCardScreen({
    Key? key,
    required this.Name,
    required this.PhoneNumber,
    required this.Email,
    required this.DateOfBirth,
    required this.Gender,
    required this.Nationality,
    required this.Education,
    required this.Address,
  }) : super(key: key);

  @override
  State<identityCardScreen> createState() => _identityCardScreenState();
}

class _identityCardScreenState extends State<identityCardScreen> {
  String? downloadurl;
  Future<String?> downloadURL() async {
    try {
      downloadurl = await FirebaseStorage.instance
          .ref()
          .child('files/${widget.Name}.jpg')
          .getDownloadURL();
      print(downloadurl);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          '${widget.Name}\'s Identity Card Screen',
          style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.10,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, TableData.id);
              },
              child: const Icon(Icons.arrow_back_ios_rounded),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: downloadURL(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something has Error');
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.deepOrange,
                        backgroundImage: NetworkImage(downloadurl!),
                        minRadius: 50,
                        maxRadius: 50,
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Name : ',
                      style: GoogleFonts.abel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.Name,
                      style: GoogleFonts.abel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 20,
                thickness: 1.0,
                endIndent: 50,
                indent: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'PHONE : ',
                      style: GoogleFonts.abel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.PhoneNumber,
                      style: GoogleFonts.abel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 20,
                thickness: 1.0,
                endIndent: 50,
                indent: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'EMAIL : ',
                      style: GoogleFonts.abel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.Email,
                      style: GoogleFonts.abel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 20,
                thickness: 1.0,
                endIndent: 50,
                indent: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'DOB : ',
                      style: GoogleFonts.abel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.DateOfBirth,
                      style: GoogleFonts.abel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 20,
                thickness: 1.0,
                endIndent: 50,
                indent: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'GENDER : ',
                      style: GoogleFonts.abel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.Gender,
                      style: GoogleFonts.abel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 20,
                thickness: 1.0,
                endIndent: 50,
                indent: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'NATIONALITY : ',
                      style: GoogleFonts.abel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.Nationality,
                      style: GoogleFonts.abel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 20,
                thickness: 1.0,
                endIndent: 50,
                indent: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'EDUCATION : ',
                      style: GoogleFonts.abel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.Education,
                      style: GoogleFonts.abel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 20,
                thickness: 1.0,
                endIndent: 50,
                indent: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'ADDRESS : ',
                      style: GoogleFonts.abel(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.Address,
                      style: GoogleFonts.abel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
