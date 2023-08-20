import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Notifiy extends StatefulWidget {
  const Notifiy({Key? key}) : super(key: key);

  @override
  State<Notifiy> createState() => _NotifiyState();
}

class _NotifiyState extends State<Notifiy> {
  @override
  Widget build(BuildContext context) {
    BoxDecoration myBoxDecoration() {
      return BoxDecoration(
        color: Colors.white70,
        border: Border.all(width: 3.0),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //                 <--- border radius here
            ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFb1c4d2),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("accept")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection('accepted')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot _documentSnapshot =
                      snapshot.data!.docs[index];
                  return Card(
                    color: Colors.white,
                    elevation: 10,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: myBoxDecoration(),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .80,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${_documentSnapshot['message']}",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "By: ${_documentSnapshot['by']}",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Pic Up Location: ${_documentSnapshot['pic-up-loc']}",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Drop Off Loc:  ${_documentSnapshot['drop-off-loc']}",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 5),
                            width: MediaQuery.of(context).size.width * .08,
                            child: IconButton(
                              iconSize: 40,
                              icon: const Icon(
                                Icons.delete,
                              ),
                              color: Colors.red,
                              // the method which is called
                              // when button is pressed
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("accept")
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .collection("accepted")
                                    .doc(_documentSnapshot.id)
                                    .delete();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      )), //Display a list // Add a FutureBuilder
    );
  }
}
