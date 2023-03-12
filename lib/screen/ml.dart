import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class mlscreen extends StatefulWidget {
  const mlscreen({super.key});

  @override
  State<mlscreen> createState() => _mlscreenState();
}

class _mlscreenState extends State<mlscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ML")),
    );
  }
}
