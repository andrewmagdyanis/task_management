import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> taskStates = List.generate(100, (i) => false);

  List<Map<String, dynamic>> dashboardData = List.generate(
      100,
      (index) => {
            'task': (index % 3 == 0)
                ? 'Home Screen'
                : (index % 2 == 0)
                    ? 'Dashboard Screen'
                    : 'Login Screen',
            'name': (index % 3 == 0)
                ? 'Ahmed'
                : (index % 2 == 0)
                    ? 'Ali'
                    : 'Andrew',
          });

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = List.generate(100, (index) {
      return TableRow(children: [
        Text(dashboardData[index]['task']),
        Text(dashboardData[index]['name']),
        Checkbox(
          value: taskStates[index],
          onChanged: (newStatus) {
            setState(() {
              taskStates[index] = newStatus!;
            });
          },
          shape: CircleBorder()
        ),
      ]);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management System'),
        centerTitle: true,
      actions: [IconButton(onPressed: (){
        FirebaseAuth.instance.signOut();
      }, icon: Icon(Icons.logout))],
      )
      ,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 8),
                child: Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.all(4),
                child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    textBaseline: TextBaseline.ideographic,
                    border: TableBorder(
                        horizontalInside: BorderSide(color: Colors.black26)),
                    columnWidths: {
                      0: FractionColumnWidth(0.65),
                      1: FractionColumnWidth(0.2),
                      2: FractionColumnWidth(0.15)
                    },
                    children: rows),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
