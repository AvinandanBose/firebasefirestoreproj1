import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'identitycardscreen.dart';

class TableData extends StatefulWidget {
  const TableData({Key? key}) : super(key: key);

  @override
  State<TableData> createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  final Future<FirebaseApp> initialization = Firebase.initializeApp();

  final Stream<QuerySnapshot> StudentStream =
      FirebaseFirestore.instance.collection('students').snapshots();

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
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(150), //0 th Column
                  1: FixedColumnWidth(100), //1st Column
                  2: FixedColumnWidth(100), //2nd Column
                },
                defaultVerticalAlignment: TableCellVerticalAlignment
                    .middle, //To keep text in the middle of the cell
                border: TableBorder.all(),
                children: <TableRow>[
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    children: <Widget>[
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
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
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
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
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
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
                  ),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(
                      children: <Widget>[
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
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
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
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
                        TableCell(
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
      // body:
    );
  }
}
