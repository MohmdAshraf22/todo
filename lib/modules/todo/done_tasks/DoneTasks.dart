import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/bloc/cubit.dart';
import 'package:todo/shared/bloc/states.dart';
import 'package:todo/shared/components/components.dart';


class DoneTasks extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDo,TodoState>(
      listener: (context, state) => {},
      builder: (context, state) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(ToDo.get(context).doneTasks[index],context),
        separatorBuilder: (context, index) => Padding(
          padding:  EdgeInsetsDirectional.only(
            start: 20,
          ),
          child: Container(
            height: 2,
            width: double.infinity,
            color: Colors.grey[400],
          ),
        ) ,
        itemCount: ToDo.get(context).doneTasks.length,
      ),
    );  }
}
