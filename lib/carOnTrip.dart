import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CarOnTrip extends StatefulWidget {
  const CarOnTrip({Key? key}) : super(key: key);

  @override
  State<CarOnTrip> createState() => _CarOnTripState();
}

class _CarOnTripState extends State<CarOnTrip> {
  var signal = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb1c4d2),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Add-Car")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection('add')
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
                  var status = _documentSnapshot['status'];
                  if (status == "Booked") signal = false;
                  if (status == "Booked")
                    return Card(
                      //padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 30),
                      color: Colors.white,
                      elevation: 10,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width * .5,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    NetworkImage("${_documentSnapshot['img']}"),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 7),
                                //color: Colors.greenAccent,
                                //margin: EdgeInsets.only(bottom: 5),
                                width: MediaQuery.of(context).size.width * .3,
                                height: 80,
                                child: Text(
                                  "Status: On Trip",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  return Card();
                });
          },
        ),
      )),
    );
  }
}
