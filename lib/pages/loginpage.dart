import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vidya/pages/forgotpage.dart';
import 'package:vidya/pages/registerpage.dart';
import 'package:vidya/posts/postpage.dart';
import 'package:vidya/utils/utils.dart';
import 'package:vidya/widgets/round_butten.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  // Future<void> logout() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   await googleSignIn.signOut();
  //   await _auth.signOut();

  // }
  // Future<void> SignInWithGoogle() async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   final GoogleSignInAccount? googleuser = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleuser!.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  //   final UserCredential userCredential =
  //       await _auth.signInWithCredential(credential);
  // }

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }

    // Trigger the authentication flow
  }

  bool loding = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  final _name = TextEditingController();

  // User? currentUser;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passWordController.dispose();
    _name.dispose();
  }

  void login() async {
    setState(() {
      loding = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passWordController.text.toString())
        .then((value) {
      FirebaseAuth.instance.currentUser!
          .updateDisplayName(_name.text.toString());
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => postpage(),
          ));
      setState(() {
        loding = false;
      });
      // currentUser = value.user;
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loding = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/loginlogo.png",
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "LOGIN",
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
                          height: 1,
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Forgotpage()));
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundButten(
                  title: "Login",
                  loading: loding,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.deepPurple.shade50,
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: Size(double.infinity, 50), //////// HERE
                  ),
                  onPressed: () async {
                    await signInWithGoogle();
                    if (mounted) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => postpage(),
                          ));
                    }
                  },
                  label: Text('Sign Up with Google'),
                  icon: Image.asset(
                    "assets/images/google.png",
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        "Register now",
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
