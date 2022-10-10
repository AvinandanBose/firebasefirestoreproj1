import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              child: Column(
            children:<Widget> [
              ...storedocs
                  .map(
                    (e) => Center(
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            backgroundImage: NetworkImage(e['photoUrl']),
                            minRadius: 50,
                            maxRadius: 50,
                          ),
                          Text(
                            'Name: ${e['Name']}',
                            style: GoogleFonts.abel(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Email: ${e['Email']}',
                            style: GoogleFonts.abel(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Phone: ${e['Phone']}',
                            style: GoogleFonts.abel(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'DOB: ${e['DOB']}',
                            style: GoogleFonts.abel(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Education: ${e['Education']}',
                            style: GoogleFonts.abel(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Gender: ${e['Gender']}',
                            style: GoogleFonts.abel(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Address: ${e['Address']}',
                            style: GoogleFonts.abel(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black87,
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            endIndent: 50,
                            indent: 50,
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ],
          ));
        },
      ),
    );
  }
}
