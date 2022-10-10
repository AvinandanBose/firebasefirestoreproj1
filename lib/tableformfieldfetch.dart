import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableFromFieldFetch extends StatefulWidget {
  const TableFromFieldFetch({Key? key}) : super(key: key);

  @override
  State<TableFromFieldFetch> createState() => _TableFromFieldFetchState();
}

class _TableFromFieldFetchState extends State<TableFromFieldFetch> {

  Stream<QuerySnapshot>? collectionIdStream;
  Future<Stream<QuerySnapshot>> getAllStartingCollection(String id) async {
    return await FirebaseFirestore.instance.collection(id).snapshots();
  }
  @override
  void initState() {
    super.initState();
    getAllStartingCollection("Address").then((value) {
      setState(() {
        collectionIdStream = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data from Firebase'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionIdStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds =
              snapshot.data?.docs[index] as DocumentSnapshot;
              return ListTile(
                title: Text(
                  ds["Address"],
                ),
              );
            },
          )
              : Container();
        },
      ),
    );
  }
}

