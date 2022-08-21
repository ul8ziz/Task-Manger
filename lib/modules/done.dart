import 'dart:ffi';

import 'package:flutter/material.dart';

class Done extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
           child:  Container(
             child: Text(
               'Done',
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 28,
                 color: Colors.blueGrey.shade200,
               ),
             ),
           ),
      ),
            );


  }
}
