import 'package:flutter/material.dart';


class fetchData extends StatefulWidget {
  const fetchData({Key? key}) : super(key: key);

  @override
  State<fetchData> createState() => _fetchDataState();
}

class _fetchDataState extends State<fetchData> {
  List<Map<String , String>> message =[ {
    'name' : 'Avinandan',
    'year' : '1983',
  },
    {
      'name' : 'Soumya',
      'year' : '1988',
    },

  ];
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
        columns:  const <DataColumn>[
          DataColumn(label: Text('Name'),),
          DataColumn(label: Text('Year'),numeric: true),
        ],
        rows:  <DataRow>[
          DataRow(
            selected: true,
            cells: <DataCell>[
              DataCell(
                Text(message[0]['name'].toString()),
                showEditIcon: true,
                placeholder: true,
              ),
              DataCell(
                Text(message[0]['year'].toString()),
              ),
            ],
          ),
          DataRow(
            selected: true,
            cells: <DataCell>[
              DataCell(
                Text(message[1]['name'].toString()),
                showEditIcon: true,
                placeholder: true,
              ),
              DataCell(
                Text(message[1]['year'].toString()),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
