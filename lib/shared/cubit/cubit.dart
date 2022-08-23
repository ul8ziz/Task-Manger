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

  List<Map>tasks=[];

  List<Widget> screens =
  [
    Tasks(),
    Done(),
    Archive(),
    Profile(),
  ];

  List<String> titles =
  [
    "New tasks",
    "Done Tasks",
    "Archived Tasks",
    "Profile",
  ];

  void changIndex(int index)
  {
    currenindxe = index;
    emit(AppChangeBottomNavBar());
  }

  late Database database;

//////createDatabase
  void createDatabase()
  {
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
          print(tasks);
          emit(AppGetDbState());
       }
        );
        print('Database Opened');
      },
    ).then((value)
    {
      database = value;
      emit(AppCreateDbState());
    });
  }

/////////// inserttoDatabase
   inserttoDatabase({
    required String title,
    required String time,
    required String date,
  }) async
  {
    String sqlInsert = 'INSERT INTO tasks(title ,date,time,status)''VALUES("$title","$date","$time","new")';
     await database.transaction((txn) async {
       txn.rawInsert(sqlInsert)
          .then((value)
       {
        emit(AppInserteDbState());
        print('$value inserted Successfully');
        ////////////GetDate
        getDateFormDatabse(database).then((value)
        {
          tasks=value;
          emit(AppGetDbState());
        });
      }).catchError((error) {
        print('Error in inserting record${error.toString()}');
      });
    });
  }

/////////getDateFormDatabse
  Future<List<Map>> getDateFormDatabse(database) async
  {
    emit(AppGetDatabesLoadingState());
    var sql = 'SELECT * FROM tasks ';
    return await database.rawQuery(sql);
  }

  bool isBootomshow = false;
  IconData botmicon = Icons.edit;
  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
})
  {
    isBootomshow=isShow;
    botmicon=icon;
    emit(AppChangeBottomSheetState());
  }


  void updateDate({
    required String status,
    required int id,
})
  async
  {
   database.rawUpdate(
        'UPDATE tasks SET status = ?,  WHERE id = ?',
        ['$status', id]).then((value) {
         emit(AppUpdateDbState());

   });
  }
}

