import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class jsscreen extends StatefulWidget {
  const jsscreen({super.key});

  @override
  State<jsscreen> createState() => _jsscreenState();
}

class _jsscreenState extends State<jsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("JavaScript")),
    );
  }
}
