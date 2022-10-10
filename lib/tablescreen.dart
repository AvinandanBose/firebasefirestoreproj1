import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text('List of Students'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
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
                  const TableRow(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    children: <Widget>[
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Name'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Email'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Action'),
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
                                onPressed: (){},
                                child: Text(storedocs[i]['Name'],
                                style: const TextStyle(color: Colors.black87),
                                )),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(storedocs[i]['Email']),
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