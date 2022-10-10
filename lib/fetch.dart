import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class fetchData extends StatefulWidget {
  const fetchData({Key? key}) : super(key: key);

  @override
  State<fetchData> createState() => _fetchDataState();
}

class _fetchDataState extends State<fetchData> {
  List<String> docIds = [];

  Future getDocIds() async {
    await FirebaseFirestore.instance.collection('Address').get().then(
          (snapshot) => snapshot.docs.forEach((element) {
            print(element.reference);
            docIds.add(element.reference.id);
          }),
        );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation of Text Form Field'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: FutureBuilder(

            future: getDocIds(),
            builder: (context, snapshot){
              List<String> docIdsUpdate = docIds.toSet().toList();
              return ListView.builder(
                  itemCount:  docIdsUpdate.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(docIdsUpdate[index]),
                    );
                  }
              );
            },
          ),


          ),

          Material(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(32),
            child: MaterialButton(
              minWidth: 200.0,
              height: 42.0,
              onPressed: () {
               setState(() {
                 docIds.clear();
               });
              },
              child: const Text(
                'clear list',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
