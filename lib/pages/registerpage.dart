import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidya/global/global.dart';
import 'package:vidya/pages/loginpage.dart';
import 'package:vidya/utils/utils.dart';
import 'package:vidya/widgets/round_butten.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  final _name = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  User? currentUser;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passWordController.dispose();
    _name.dispose();
  }

  void register() async {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passWordController.text.toString())
        .then((value) {
      value.user!.updateDisplayName(_name.text.toString());
      // value.user?.updateDisplayName();

      setState(() {
        Util().toastMessage("Account created");
        loading = false;
      });
      currentUser = value.user;
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });

    // if (currentUser != null) {
    //   saveInfoFirestoreAndLocally(currentUser!);
    // }
  }

  // saveInfoFirestoreAndLocally(User currentUser) async {
  //   // save to firestore
  //   FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
  //     "uid": currentUser.uid,
  //     "email": currentUser.email,
  //     "name": _name.text.trim(),
  //     "status": "approved",
  //     "userCart": ["initialValue"],
  //   });

  //   // save locally
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences!.setString("uid", currentUser.uid);
  //   await sharedPreferences!.setString("email", currentUser.email!);
  //   await sharedPreferences!.setString("name", _name.text.trim());
  //   await sharedPreferences!.setStringList("userCart", ["initialValue"]);
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/login_image.png",
                fit: BoxFit.cover,
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _name,
                          keyboardType: TextInputType.name,
                          // showCursor: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Name",
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
                                Icons.account_circle,
                                size: 28,
                              )),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter your user email.';
                          //   } else if (!RegExp(
                          //           r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          //       .hasMatch(value)) {
                          //     return 'Enter Correct Email Address';
                          //   }
                          //   return null;
                          // },
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                            } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Enter Correct Email Address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passWordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          // showCursor: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
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
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter your user email.';
                          //   } else if (!RegExp(
                          //           r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          //       .hasMatch(value)) {
                          //     return 'Enter Correct Email Address';
                          //   }
                          //   return null;
                          // },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundButten(
                  title: "Register",
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      register();
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginpage()));
                      },
                      child: Text(
                        "Login now",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
