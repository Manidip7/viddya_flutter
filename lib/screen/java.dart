import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vidya/widgets/round_butten.dart';

class javascreen extends StatefulWidget {
  const javascreen({super.key});

  @override
  State<javascreen> createState() => _javascreenState();
}

class _javascreenState extends State<javascreen> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('Java').snapshots();
  String htmlData = "";

  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
// final firestoreInstance = FirebaseFirestore.instance;

// firestoreInstance.collection('users').get().then((querySnapshot) {
//   String firestoreData = '';

//   querySnapshot.docs.forEach((doc) {
//     firestoreData += doc.data().toString() + '<br>';
//   });

//   // Display the Firestore data in a WebView
//   _controller.loadUrl('data:text/html;base64,${base64Encode(const Utf8Encoder().convert(firestoreData))}');
// });
// Text('${snapshot.data?.docs[3]['Data']}');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Java")),
        body: Container(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: studentsStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          print("Something went Wrong");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        // final List storedocs = [];
                        // snapshot.data!.docs.map((DocumentSnapshot document) {
                        // Map a = document.data() as Map<String, dynamic>;
                        // storedocs.add(a);

                        for (var i = 0; i < snapshot.data!.docs.length; i++) {
                          htmlData = htmlData + snapshot.data?.docs[i]['Data'];
                        }

                        // }).toList();
                        return SingleChildScrollView(
                          child: Html(
                            data: htmlData,
                            style: {
                              'h1': Style(color: Colors.red),
                              'h2': Style(color: Colors.red),
                            },
                          ),
                        );
                        // ListView.builder(
                        //   // child: RoundButten(
                        //   //   title: "Login",
                        //   //   onTap: () {
                        //   //     // print(storedocs);
                        //   //     print(htmlData);
                        //   //   },
                        //   // ),
                        //   // child: SingleChildScrollView(
                        //   //   child: Html(data: htmlData),
                        //   // ),
                        //   itemCount: snapshot.data!.docs.length,
                        //   itemBuilder: (BuildContext context, int index){z
                        //     return SingleChildScrollView(
                        //       child: Html(data: ),
                        //     )
                        //   },

                        // );
                      }),
                ),
              ),
            ],
          ),
        )));
  }
}
