import 'package:flutter/material.dart';

import '../shared/components/component.dart';
import '../shared/components/conastants.dart';

class Tasks extends StatelessWidget {
  const Tasks({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context,index)=>ul8zizListItem(tasks[index]),
        separatorBuilder: (context,index)=>Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 2.0,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: tasks.length,
    );
  }
}
