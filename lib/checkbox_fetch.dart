import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckBox_Fetch extends StatefulWidget {
  const CheckBox_Fetch({Key? key}) : super(key: key);

  @override
  State<CheckBox_Fetch> createState() => _CheckBox_FetchState();
}

class _CheckBox_FetchState extends State<CheckBox_Fetch> {
  Stream<QuerySnapshot>? collectionIdStream;
  Future<Stream<QuerySnapshot>> getAllStartingCollection(String id) async {
    return await FirebaseFirestore.instance.collection(id).snapshots();
  }

  @override
  void initState() {
    super.initState();
    getAllStartingCollection("Hobbies").then((value) {
      setState(() {
        collectionIdStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data from Check Box'),
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
                        ds["Hobby"],
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
