import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger/shared/cubit/cubit.dart';

import '../shared/components/component.dart';
import '../shared/cubit/states.dart';

class Archive extends StatelessWidget {
  const Archive({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var tasks=AppCubit.get(context).archiveTasks;
        return tasksBuilder(
          tasks: tasks,
        );
      },
    );
  }}
