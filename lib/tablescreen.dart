import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'editscreen.dart';
import 'identitycardscreen.dart';

class TableData extends StatefulWidget {
  const TableData({Key? key}) : super(key: key);

  @override
  State<TableData> createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  bool isDeleted = false;
  final Future<FirebaseApp> initialization = Firebase.initializeApp();

  final Stream<QuerySnapshot> StudentStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  Future<String?> delete(String ref) async {
    try {
      await FirebaseStorage.instance.ref(ref).delete();

      setState(() {
        isDeleted = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteUser(id) async {
    try {
      await students
          .doc(id)
          .delete()
          .then((value) => print('User Deleted'))
          .catchError((error) => print('Failed to delete user : $error'));
      setState(() {
        isDeleted = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text(
          'List of Students',
          style: GoogleFonts.abhayaLibre(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        actions: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_rounded),
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: StudentStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
            Map a = documentSnapshot.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = documentSnapshot.id;
            print(storedocs);
          }).toList();
          return SingleChildScrollView(
            child: DataTable(
              dataRowHeight:
                  (MediaQuery.of(context).size.height - 56) / storedocs.length,
              columnSpacing: 5,
              horizontalMargin: 1,
              headingRowColor: MaterialStateColor.resolveWith((states) => Colors.redAccent),
              showBottomBorder: true,
              dataRowColor: MaterialStateColor.resolveWith((states) => Colors.greenAccent),
              border: TableBorder.all(
                width: 2,
                color: Colors.black87,
              ),
              columns: <DataColumn>[
                DataColumn(
                  label: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: Text(
                        'Name',
                        style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: Text(
                        'Email',
                        style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        'Action',
                        style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              rows: <DataRow>[
                for (var i = 0; i < storedocs.length; i++) ...[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return identityCardScreen(
                                      Name: storedocs[i]['Name'],
                                      PhoneNumber: storedocs[i]['Phone'],
                                      Email: storedocs[i]['Email'],
                                      DateOfBirth: storedocs[i]['DOB'],
                                      Gender: storedocs[i]['Gender'],
                                      Nationality: storedocs[i]['Nationality'],
                                      Education: storedocs[i]['Education'],
                                      Address: storedocs[i]['Address'],
                                    );
                                  }));
                            },
                            child: Center(
                              child: Text(
                                storedocs[i]['Name'],
                                style: GoogleFonts.abel(
                                  fontSize: 19,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            storedocs[i]['Email'],
                            style: GoogleFonts.abel(
                              fontSize: 19,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(

                          child: Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return editScreen(id: storedocs[i]['id'], name: storedocs[i]['Name'],);
                                    }),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: ()async {
                                  await delete('files/${storedocs[i]['Name']}.jpg');
                                  deleteUser(storedocs[i]['id']);
                                  if(isDeleted == true){
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
                                          'Data Deleted Successfully',
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
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
      // body:
    );
  }
}
