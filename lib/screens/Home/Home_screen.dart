import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/Profile.dart';
import '../../modules/tasks.dart';
import '../../modules/Archive.dart';
import '../../modules/done.dart';
import '../../shared/components/component.dart';
import '../../shared/components/conastants.dart';

class Home extends StatelessWidget {

  var titlController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  int currenindxe = 0;
  bool isBootomshow = false;
  IconData botmicon = Icons.edit;
  List<Widget> screens = [
    Tasks(),
    Done(),
    Archive(),
    Profile(),
  ];
  List<String> titles = [
    "New tasks",
    "Done Tasks",
    "Archived Tasks",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(titles[currenindxe]),
        ),
        body:  screens[currenindxe],
        floatingActionButton:Padding(
            padding: EdgeInsets.fromLTRB(0,0,10,25.0),
            child: FloatingActionButton(
          onPressed: () {
            if (isBootomshow) {
              if (formKey.currentState!.validate()) {
                inserttoDatabase(
                  title: titlController.text,
                  time: timeController.text,
                  date: dateController.text,
                ).then((value) {
                  Navigator.pop(context);
                  isBootomshow = false;
                  // setState(() {
                  //   botmicon = Icons.edit;
                  // });
                });
              }}
            else {
              scaffoldKey.currentState
                  ?.showBottomSheet((context) => Container(
                        // margin: EdgeInsets.all(15),
                        color: Colors.blueGrey[50],
                        padding: EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ul8zizFormField(
                                labl: 'Task Title',
                                controller: titlController,
                                Type: TextInputType.text,
                                ispassword: false,
                                perfix: Icons.title,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Title must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              ul8zizSizeblBox(),
                              ul8zizFormField(
                                labl: 'Task Time',
                                controller: timeController,
                                Type: TextInputType.datetime,
                                // isClickable: false,
                                ontap: () {
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((value) {
                                    print(value?.format(context));
                                    timeController.text =
                                        value!.format(context).toString();
                                  });
                                },
                                perfix: Icons.timer,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Time must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              ul8zizSizeblBox(),
                              ul8zizFormField(
                                labl: 'Task Date',
                                controller: dateController,
                                Type: TextInputType.datetime,
                                //isClickable: false,
                                ontap: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse('2023-02-22'))
                                      .then((value) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value!);
                                  });
                                },
                                perfix: Icons.timer,
                                validate: ( value) {
                                  if (value.isEmpty) {
                                    return 'Date must not be empty';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ))
                  .closed
                  .then((value) {
                isBootomshow = false;
                // setState(() {
                //   botmicon = Icons.edit;
                // });
              });
              isBootomshow = true;
              // setState(() {
              //   botmicon = Icons.add;
              // });
            }   },

          child: Icon(botmicon),
        )),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currenindxe,
          onTap: (indxe) {
            // setState(() {
            //   currenindxe = indxe;
            // });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_outlined), label: 'Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline_sharp), label: 'Done'),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive), label: 'Archive'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Profile'),
          ], ),
      ),
    );
  }}


late Database database;
//////createDatabase
void createDatabase() async {
  database = await openDatabase(
    'todo.db',
    version: 1,
    onCreate: (database, version) {
      print('Database Created');
      String sql =
          'Create Table tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT )';
      database.execute(sql).then((value) {
        print('Table Created');
      }).catchError((error) {
        print('Error in creating table ${error.toString()}');
      });
    },
    onOpen: (database)
    {
      getDateFormDatabse(database).then((value)
      {
         tasks=value;

      });
      print('Database Opened');
    });
}

/////////// inserttoDatabase
Future inserttoDatabase({
  required String title,
  required String time,
  required String date,
}) async {
  String sqlInsert = 'INSERT INTO tasks(title ,date,time,status)'
      'VALUES("$title","$date","$time","new")';
  return await database.transaction((txn) async {
    await txn.rawInsert(sqlInsert).then((value) {
      print('$value inserted Successfully');
      print('${"$title  " "$time  " " $date"}');
    }).catchError((error) {
      print('Error in inserting record${error.toString()}');
    });
  });
}

/////////getDateFormDatabse
Future<List<Map>> getDateFormDatabse(database)async
{
  var sql='SELECT * FROM tasks ';
 return await  database.rawQuery(sql);
  //
}