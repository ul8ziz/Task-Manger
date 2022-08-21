import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manger/shared/cubit/states.dart';

import '../../modules/Archive.dart';
import '../../modules/Profile.dart';
import '../../modules/done.dart';
import '../../modules/tasks.dart';
import '../components/conastants.dart';
import 'package:flutter/material.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currenindxe = 0;

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

  void changIndex(int index) {
    currenindxe = index;
    emit(AppChangeBottomNavBar());
  }

  late Database database;

//////createDatabase
  void createDatabase() {
    openDatabase(
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
      onOpen: (database) {
        getDateFormDatabse(database).then((value) {
          tasks = value;
          emit(AppGetDbState());
       }
        );
        print('Database Opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDbState());
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
  Future<List<Map>> getDateFormDatabse(database) async {
    var sql = 'SELECT * FROM tasks ';
    return await database.rawQuery(sql);
    //
  }
}
