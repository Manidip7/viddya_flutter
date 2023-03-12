import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class sqlscreen extends StatefulWidget {
  const sqlscreen({super.key});

  @override
  State<sqlscreen> createState() => _sqlscreenState();
}

class _sqlscreenState extends State<sqlscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQL"),
      ),
    );
  }
}
