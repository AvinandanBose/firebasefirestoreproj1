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
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.redAccent),
              showBottomBorder: true,
              dataRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.greenAccent),
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
              rows: storedocs
                  .map(
                    (e) => DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return identityCardScreen(
                                      Name: e['Name'],
                                      PhoneNumber: e['Phone'],
                                      Email: e['Email'],
                                      DateOfBirth: e['DOB'],
                                      Gender: e['Gender'],
                                      Nationality: e['Nationality'],
                                      Education: e['Education'],
                                      Address: e['Address'],
                                    );
                                  }),
                                );
                              },
                              child: Center(
                                child: Text(
                                  e['Name'],
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
                              e['Email'],
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

                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  onPressed: ()  {

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
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
