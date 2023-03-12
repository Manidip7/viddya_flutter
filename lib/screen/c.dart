import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class cscreen extends StatefulWidget {
  const cscreen({super.key});

  @override
  State<cscreen> createState() => _cscreenState();
}

class _cscreenState extends State<cscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("C")),
    );
  }
}
