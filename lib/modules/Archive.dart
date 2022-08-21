import 'package:flutter/material.dart';

class Archive extends StatelessWidget {
  const Archive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          'Archive',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.blueGrey.shade200,
          ),
        ),
      ),
    );
  }
}
