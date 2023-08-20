import 'package:car_renting_system/ownerNotifi.dart';
import 'package:car_renting_system/search.dart';
import 'package:car_renting_system/searchauth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchSelected extends StatefulWidget {
  final String text;
  const SearchSelected({Key? key, required this.text}) : super(key: key);

  @override
  State<SearchSelected> createState() => _SearchSelectedState(text);
}

class _SearchSelectedState extends State<SearchSelected> {
  var Notificationgmail;
  var email;
  var ID;
  _SearchSelectedState(String text) {
    print(text);
    email = text;
  }

  @override
  Widget build(BuildContext context) {
    //var email = Search().gmail;
    print("selectedggg$email");
    var picUpLoc;
    var dropOffLoc;
    var picUpTime;
    var dropOffTime;
    var sendReq;
    var passengerEmail;

    sendData() async {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      var currentUser = _auth.currentUser;

      var collection = FirebaseFirestore.instance.collection('add-trip');
      var docSnapshot = await collection.doc(currentUser!.email).get();
      Map<String, dynamic>? data = docSnapshot.data();
      picUpLoc = data?["pic-up-loc"];
      dropOffLoc = data?["return-loc"];
      picUpTime = data?["pic-uo-time"];
      dropOffTime = data?["return-time"];
      passengerEmail = currentUser.email;
      print("email = $passengerEmail");

      print("collect data $data");
      print(picUpTime);
      print(picUpLoc);
      print(dropOffTime);
      print(dropOffLoc);
      final FirebaseAuth auth = FirebaseAuth.instance;
      var _currentUser = auth.currentUser;
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection("request");
      print(currentUser.email);
      print(_collectionRef);
      return _collectionRef.doc(email).collection('add-req').doc().set({
        "pic-up-loc": picUpLoc.toString(),
        "pic-up-time": picUpTime.toString(),
        "drop-off-loc": dropOffLoc.toString(),
        "drop-off-time": dropOffTime.toString(),
        "passenger-email": passengerEmail.toString(),
        "car-id": ID.toString(),
      }).catchError((error) => print("somethimg is wrong. $error"));
      print("created");
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Car Renting Service Center",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Add-Car")
                .doc(email)
                .collection('add')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              final FirebaseAuth _auth = FirebaseAuth.instance;

              //var rate = collecData();
              //print("rateing = $rate");

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
                    int ratecar = _documentSnapshot['rate-car'];
                    print("car id = ");
                    var Id = _documentSnapshot.id;
                    print(Id);
                    var collection =
                        FirebaseFirestore.instance.collection('Add-Car');
                    collection
                        .doc(email)
                        .collection('add')
                        .doc(Id) // <-- Doc ID where data should be updated.
                        .update({'car-id': Id}) // <-- Updated data
                        .then((_) => print('Updated'))
                        .catchError((error) => print('Update failed: $error'));
                    return Card(
                      color: Colors.white,
                      elevation: 10,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width * .6,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    NetworkImage("${_documentSnapshot['img']}"),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${_documentSnapshot['car-name']}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Seat No: ${_documentSnapshot['seat-no']}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Catagory: ${_documentSnapshot['catagory']}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                color: Colors.yellowAccent,
                                child: Text(
                                  "Rating: $ratecar",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .3,
                                height: 50,
                                margin: EdgeInsets.only(
                                    left: 20, top: 20, bottom: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Fluttertoast.showToast(
                                        msg: 'Request Sent Successfully');
                                    ID = _documentSnapshot.id;
                                    sendData();
                                  },
                                  child: Text("Request Car"),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    onPrimary: Colors.white,
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontStyle: FontStyle.normal),
                                    minimumSize: Size(50, 50),
                                    padding: EdgeInsets.all(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
      )), //Display a list // Add a FutureBuilder
    );
  }
}
