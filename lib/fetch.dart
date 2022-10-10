import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class fetchData extends StatefulWidget {
  const fetchData({Key? key}) : super(key: key);

  @override
  State<fetchData> createState() => _fetchDataState();
}



class _fetchDataState extends State<fetchData> {
  Stream<QuerySnapshot>? collectionIdStream;
  Future<Stream<QuerySnapshot>> getAllStartingCollection(String id)async{
    return await FirebaseFirestore.instance.collection(id).snapshots();

  }

  @override
  void initState() {
    super.initState();
      getAllStartingCollection("Gender0").then((value) {
        setState(() {
          collectionIdStream = value;
        });
      });

  }


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
        builder: (context,snapshot){
          return snapshot.hasData
              ?ListView.builder(
            itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index){
                DocumentSnapshot ds =
                snapshot.data?.docs[index] as DocumentSnapshot;
                return ListTile(
                  title: Text(ds["Gender"],
                  ),

                );
              },
          ): Container();
        },

      ),

    );
  }
}
