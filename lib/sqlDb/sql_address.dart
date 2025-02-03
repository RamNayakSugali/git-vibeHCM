import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vibeshr/database_helper.dart';
import 'package:vibeshr/untils/export_file.dart';

class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  final TextEditingController _taskController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  List<Data> _dataList = [];
  @override
  void initState() {
    super.initState();
    // _refreshDataList();
  }

  void _refreshDataList() async {
    List<Data> dataList = await _databaseHelper.getDataList();
    setState(() {
      _dataList = dataList;
    });
  }

  // void _addData() async {
  //   Data newData = Data(
  //     id: 0,
  //     name1: _name1Controller.text,
  //     name2: _name2Controller.text,
  //     name3: _name3Controller.text,
  //   );
  //   await _databaseHelper.insertData(newData);
  //   _refreshDataList();

  // }

  // void _refreshTaskList() async {
  //   List<Task> address = await _databaseHelper.getaddress();
  //   setState(() {
  //     _address = address;
  //   });
  // }

  // void _addTask(String location, String latitude, String longitude) async {
  //   Task newTask =
  //       Task(location: location, latitude: latitude, longitude: longitude);
  //   await _databaseHelper.insertTask(newTask);
  //   _refreshTaskList();
  // }

  // void _deleteTask(int taskId) async {
  //   await _databaseHelper.deleteTask(taskId);
  //   _refreshTaskList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VibhoAppBar(
        title: "SQl Data Base",
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.abc),
        onPressed: () {
          _refreshDataList();
        },
      ),
      body: Column(
        children: [
          GestureDetector(
              onTap: () async {
                //   await _databaseHelper.del(_dataList[0].name1);

                //   ///
                //   /// Delete the database at the given path.
                //   ///
                //   // Future<void> deleteDatabase(String path) =>
                //   //     _databaseHelper.database;
              },
              child: Text("Test")),
          Container(
            height: 200.h,
            child: ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'SI no ${index} , Address  ${_dataList[index].name1},  Latitude ${_dataList[index].name2}, Longitude ${_dataList[index].name3}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Container(
      //   margin: EdgeInsets.all(15.w),
      //   child:
      //   ListView.builder(
      //     itemCount: _address.length,
      //     itemBuilder: (context, index) {
      //       return Padding(
      //         padding: EdgeInsets.all(8.r),
      //         child: Column(
      //           children: [
      //             Text("${index.toString()} ${_address[index].location}"),
      //             Text("${index.toString()} ${_address[index].latitude}"),
      //             Text("${index.toString()} ${_address[index].longitude}"),
      //           ],
      //         ),
      //       );
      //       // ListTile(
      //       //   title: Text(_address[index].name),
      //       //   trailing: Checkbox(
      //       //     value: _address[index].isDone,
      //       //     onChanged: (value) {
      //       //       _updateTask(_address[index]);
      //       //     },
      //       //   ),
      //       //   onLongPress: () {
      //       //     _deleteTask(_address[index].id);
      //       //   },
      //       // );
      //     },
      //   ),
      // ),
    );
  }
}
