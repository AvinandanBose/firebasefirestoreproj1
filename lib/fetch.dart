import 'package:flutter/material.dart';


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
        title: const Text('Creation of Data Table'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: DataTable(
        sortColumnIndex: 0,
        sortAscending: true,
        columns: const <DataColumn>[
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Year'),numeric: true),
        ],
        rows: const <DataRow>[
          DataRow(
            selected: true,
            cells: <DataCell>[
              DataCell(
                Text('Avinandan'),
                showEditIcon: true,
                placeholder: true,
              ),
              DataCell(
                Text('1893'),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                Text('Soumya'),
              ),
              DataCell(
                Text('1895'),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                Text('Finnish'),
              ),
              DataCell(
                Text('1991'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
