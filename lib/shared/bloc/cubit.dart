import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/modules/todo/archieve_tasks/archivedTasks.dart';
import 'package:todo/modules/todo/done_tasks/DoneTasks.dart';
import 'package:todo/modules/todo/newtask/NewTasks.dart';

import 'package:todo/shared/bloc/states.dart';
import 'package:sqflite/sqflite.dart';

class ToDo extends Cubit<TodoState> {
  ToDo() : super(InitialState());

  static ToDo get(context) => BlocProvider.of(context);
  int current = 0;
  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];
  List<String> title = [
    'New Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];

  void change(int value) {
    current = value;
    emit(AppChangeBottom());
  }

  ///////////////////
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

   createDatabase() {
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version) {
          print('database created');
          database.execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
              .then((value) {
            print('table created');
          }).catchError((error) {
            print('error ${error.toString()}');
          });
        },
        onOpen: (database) {
          getDatabase(database);
          print('database opened');
        }
    ).then((value) {
      database = value;
      emit(CreateState());
    });
  }

   insertDatabase({
    required String title,
    required String date,
    required String time,
  }) async
  {
     await database.transaction((txn) async
    {
      txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print("$value inserted");
        emit(InsertState());
        getDatabase(database);

      }).catchError((error) {
        print('error ${error.toString()}');
      });
    });
  }

   getDatabase(database)
  {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(GetLoadingState());
      database.rawQuery('SELECT * FROM tasks').then((value) {
        value.forEach((element) {
          if(element['status'] == 'new'){
            newTasks.add(element);
          }
          else if(element['status'] == 'done'){
            doneTasks.add(element);
          }
          else
            {
              archiveTasks.add(element);
            }
         });
      emit(GetState());
    });
  }

   UpdateData({
  required String status,
  required int id,
})
  {
     database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [ '$status' , id],
    ).then((value)
     {
       getDatabase(database);
       emit(UpdateState());
     });
  }


   DeleteData({
    required int id,
  })
  {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value)
    {
      getDatabase(database);
      emit(DeleteState());
    });
  }

  IconData fabIcon = Icons.edit;
  bool isBottomSheet = false;

void ChangeBottomSheet({
  required bool isShow,
  required IconData icon,
}){
  isBottomSheet = isShow;
  fabIcon = icon;
  emit(ChangeBottomState());
}
}
