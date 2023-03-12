import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class pythonscreen extends StatefulWidget {
  const pythonscreen({super.key});

  @override
  State<pythonscreen> createState() => _pythonscreenState();
}

class _pythonscreenState extends State<pythonscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Python")),
    );
  }
}
