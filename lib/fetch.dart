import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class fetchData extends StatefulWidget {
  const fetchData({Key? key}) : super(key: key);

  @override
  State<fetchData> createState() => _fetchDataState();
}

class _fetchDataState extends State<fetchData> {
  final Stream<QuerySnapshot> StudentStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Creation of Data Table'),
          backgroundColor: Colors.lightBlueAccent,
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: StudentStream,
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
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('Email'),
                  ),
                  DataColumn(

                    label: Text('Action'),
                  ),

                ],
                rows: <DataRow>[
                  for (var i = 0; i < storedocs.length; i++) ...[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text(storedocs[i]['name']),
                        ),
                        DataCell(
                          Text(storedocs[i]['email']),
                        ),
                        DataCell(
                         Row(
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
                         )
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        ));
  }
}

