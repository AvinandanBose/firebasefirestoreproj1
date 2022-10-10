import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class fetchData extends StatefulWidget {
  const fetchData({Key? key}) : super(key: key);

  @override
  State<fetchData> createState() => _fetchDataState();
}

class _fetchDataState extends State<fetchData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation of Table'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Table(
            columnWidths: const <int , TableColumnWidth>{
              0: FixedColumnWidth(140), //0 th Column
              1: FixedColumnWidth(140), //1st Column
            } ,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle, //To keep text in the middle of the cell
            border: TableBorder.all(),
            children:  const <TableRow>[
              TableRow(
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
                      child: Text('Class'),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Roll No.'),
                    ),
                  ),
                ],
              ),
              TableRow(

                children: <Widget>[
                  TableCell(

                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Avinandan Bose'),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('X'),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('19'),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Souvik  Paul'),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('XII'),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('18'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
