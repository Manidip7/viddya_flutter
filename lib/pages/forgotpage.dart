import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vidya/utils/utils.dart';

import '../widgets/round_butten.dart';

class Forgotpage extends StatefulWidget {
  const Forgotpage({super.key});

  @override
  State<Forgotpage> createState() => _ForgotpageState();
}

class _ForgotpageState extends State<Forgotpage> {
  final _emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  // showCursor: true,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepPurpleAccent, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      // floatingLabelStyle: TextStyle(
                      //     color: Colors.deepPurpleAccent,
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.w300),
                      prefixIcon: Icon(
                        Icons.email,
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your user email.';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Enter Correct Email Address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RoundButten(
              title: "Login",
              onTap: () {
                auth
                    .sendPasswordResetEmail(
                        email: _emailController.text.toString())
                    .then((value) {
                  Utils().toastMessage(
                      "we have send you email to recover password, pleace check email");
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
