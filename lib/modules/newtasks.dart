import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger/shared/cubit/cubit.dart';
import 'package:task_manger/shared/cubit/states.dart';

import '../shared/components/component.dart';
import '../shared/components/conastants.dart';

class Tasks extends StatelessWidget {
  const Tasks({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

  return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var tasks=AppCubit.get(context).newTasks;
        return tasksBuilder(
          tasks: tasks,
        );
      },
  );
  }
}
