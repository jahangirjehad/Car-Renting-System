import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OwnerNotifi extends StatefulWidget {
  const OwnerNotifi({Key? key}) : super(key: key);

  @override
  State<OwnerNotifi> createState() => _OwnerNotifiState();
}

class _OwnerNotifiState extends State<OwnerNotifi> {
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Colors.white70,
      border: Border.all(width: 3.0),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }

  var ID;
  var picUpLoc;
  var dropOffLoc;
  var picUpTime;
  var dropOffTime;
  var sendReq;
  var passengerEmail;

  collecData() async {}

  onTripFunction() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("Add-Car");
    return _collectionRef
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("add")
        .doc(ID)
        .update({
      "status": "Booked",
    });
  }

  tripHistroy() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    print(passengerEmail);
    final FirebaseAuth auth = FirebaseAuth.instance;
    var _currentUser = auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("trip-history");
    print(currentUser!.email);
    print(_collectionRef);
    return _collectionRef.doc(passengerEmail).collection('trip').doc().set({
      "accept-by": currentUser.email.toString(),
      "pic-up-loc": picUpLoc.toString(),
      "drop-off-loc": dropOffLoc.toString(),
      "drop-off-time": dropOffTime.toString(),
      "pic-up-time": picUpTime.toString(),
      "car-ID": ID,
    }).catchError((error) => print("somethimg is wrong. $error"));
  }

  sendData(msg) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    print(passengerEmail);
    final FirebaseAuth auth = FirebaseAuth.instance;
    var _currentUser = auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("accept");
    print(currentUser!.email);
    print(_collectionRef);
    return _collectionRef.doc(passengerEmail).collection('accepted').doc().set({
      "message": msg.toString(),
      "by": currentUser.email.toString(),
      "pic-up-loc": picUpLoc.toString(),
      "drop-off-loc": dropOffLoc.toString(),
    }).catchError((error) => print("somethimg is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb1c4d2),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("request")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection('add-req')
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
                  passengerEmail = _documentSnapshot['passenger-email'];
                  picUpLoc = _documentSnapshot['pic-up-loc'];
                  dropOffLoc = _documentSnapshot['drop-off-loc'];
                  dropOffTime = _documentSnapshot['drop-off-time'];
                  picUpTime = _documentSnapshot['pic-up-time'];

                  return Card(
                    color: Colors.white,
                    elevation: 10,
                    child: Container(
                      decoration: myBoxDecoration(),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "Passenger Name: ${_documentSnapshot['passenger-email']}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Pic Up Location: ${_documentSnapshot['pic-up-loc']}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Drop Off Loc:  ${_documentSnapshot['drop-off-loc']}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Pic Up Time:  ${_documentSnapshot['pic-up-time']}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Drop Off Time:  ${_documentSnapshot['drop-off-time']}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Fluttertoast.showToast(
                                        msg: 'Request Accepted');
                                    ID = _documentSnapshot['car-id'];
                                    String msg2 = "Your Request Is Accepted ";
                                    onTripFunction();
                                    sendData(msg2);
                                    tripHistroy();
                                    FirebaseFirestore.instance
                                        .collection("request")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                        .collection("add-req")
                                        .doc(_documentSnapshot.id)
                                        .delete();
                                  },
                                  child: Text("Accept"),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.greenAccent,
                                    onPrimary: Colors.white,
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal),
                                    //minimumSize: Size(50, 50),
                                    // padding: EdgeInsets.all(10),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * .3),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Fluttertoast.showToast(
                                        msg: 'Request Declined');
                                    String msg1 = "Your Request Is Cancelled ";
                                    sendData(msg1);
                                    FirebaseFirestore.instance
                                        .collection("request")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                        .collection("add-req")
                                        .doc(_documentSnapshot.id)
                                        .delete();
                                  },
                                  child: Text("Cancel"),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    onPrimary: Colors.white,
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal),
                                    //minimumSize: Size(50, 50),
                                    //padding: EdgeInsets.all(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
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
