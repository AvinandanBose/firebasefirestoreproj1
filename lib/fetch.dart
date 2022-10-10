import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class fetchData extends StatefulWidget {
  const fetchData({Key? key}) : super(key: key);

  @override
  State<fetchData> createState() => _fetchDataState();
}

class _fetchDataState extends State<fetchData> {
  int a = 0;
  TextEditingController textEditingController = TextEditingController();
  List<String> docIds = [];
  Future getDocIds() async {
    await FirebaseFirestore.instance.collection('Address').get().then(
          (snapshot) => snapshot.docs.forEach((element) {
        print(element.reference);
        docIds.add(element.reference.id);
      }),
    );
  }

    Future<dynamic> addAddress(Map<String, String> messageMap) async {
      return await FirebaseFirestore.instance
          .collection("Address")
          .doc("$a")
          .set(messageMap)
          .catchError((e) {
        print(e);
        throw ' No data has been set';
      });
    }





@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocIds();
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
          const Text('Address'),
          TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.greenAccent,
                  width: 5.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlueAccent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
            ),
            controller: textEditingController,
            onChanged: (String address) {
              setState(() {
                textEditingController.text = address;
                textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: textEditingController.text.length));

              });
            },
            cursorColor: Colors.green,
            cursorHeight: 20,
            cursorRadius: Radius.circular(30),
            cursorWidth: 5,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Material(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(32),
            child: MaterialButton(
              minWidth: 200.0,
              height: 42.0,
              onPressed: () async {
                Map<String, String> messagemap = {
                  "Address": textEditingController.text
                };
                await getDocIds();
                if(getDocIds()==null){
                  docIds.clear();
                }
                setState(() {
                  textEditingController.clear();
                    if(docIds.isEmpty == true){
                      addAddress(messagemap);
                    }
                    else{
                      a= int.parse(docIds.last) +1;
                      print(a);
                    }
                  addAddress(messagemap);
                });

              },
              child: const Text(
                'Enter Data',
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