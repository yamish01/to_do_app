import 'package:flutter/material.dart';
import 'package:to_do_app/to_do_io.dart';
import 'package:to_do_app/to_do_model.dart';
import 'package:intl/intl.dart';

class To_Do_List extends StatefulWidget {
  const To_Do_List({super.key});

  @override
  State<To_Do_List> createState() => _To_Do_ListState();
}

class _To_Do_ListState extends State<To_Do_List> {
  var list = <ToDoModel>[];
  var textcontroller = TextEditingController();
  var searchController = TextEditingController();
  String selectedDate = DateTime.now.toString();
  var simpleDateFormat = DateFormat("dd/MMM/yyyy");
  TodoDbIO todoDbIO = TodoDbIO();
  void _showDialogFunction() {
    selectedDate = simpleDateFormat.format(DateTime.now());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, alertState) {
            return AlertDialog(
                title: const Text("Add item"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          var returnValue = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030));
                          print("returnValue $returnValue");
                          selectedDate = simpleDateFormat
                              .format(returnValue ?? DateTime.now());
                          // selectedDate = returnValue.toString();
                          alertState(() {});
                        },
                        child: Text("Pick Date $selectedDate")),
                    TextField(
                      controller: textcontroller,
                      decoration: InputDecoration(hintText: "Enter task"),
                    )
                  ],
                ),
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        if (textcontroller.text.toString().isNotEmpty) {
                          var toDoModel = ToDoModel(
                              isCompleted: 0,
                              date: selectedDate,
                              task: textcontroller.text.toString());
                          //database store
                          todoDbIO.insertIntoTaskTable(toDoModel);
                          // list.add(ToDoModel(
                          //     isCompleted: 0,
                          //     date: DateTime.now().toString(),
                          //     task: textcontroller.text.toString()));
                          Navigator.of(context).pop();
                          setState(() {});
                        }
                      },
                      child: Text("add task"))
                ]);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Search",
                  counterText: "",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.circular(50)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Text("this is the text");
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialogFunction,
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
