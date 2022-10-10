import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'identitycardscreen.dart';

class fetch extends StatefulWidget {
  const fetch({Key? key}) : super(key: key);

  @override
  State<fetch> createState() => _fetchState();
}

class _fetchState extends State<fetch> {
  Stream<QuerySnapshot>? collectionIdStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionIdStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Table(
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(170), //0 th Column
                          1: FixedColumnWidth(120), //1st Column
                          2: FixedColumnWidth(130), //2nd Column
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
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds =
                              snapshot.data?.docs[index] as DocumentSnapshot;
                          return Table(
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
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) {
                                                  return identityCardScreen(
                                                    Name: ds["Name"],
                                                    PhoneNumber: ds["Phone"],
                                                    Email: ds["Email"],
                                                    DateOfBirth: ds["DOB"],
                                                    Gender: ds["Gender"],
                                                    Nationality: ds["Nationality"],
                                                    Education: ds["Education"],
                                                    Address: ds["Address"],
                                                  );
                                                }),
                                              );
                                            },
                                            child: Center(
                                              child: Text(
                                                ds["Name"],
                                                style: GoogleFonts.abel(
                                                  color: Colors.black87,
                                                  fontSize: 20,
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
                                          child: Center(
                                            child: Text(
                                              ds["Email"],
                                              style: GoogleFonts.abel(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
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
                                              color: Colors.black87,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      )),
                                    ])
                              ]);
                        },
                      ),
                    ],
                  ),
                )
              : const CircularProgressIndicator();
        },
      ),
    );
  }
}
