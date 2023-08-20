import 'dart:ui';

import 'package:car_renting_system/hirecar.dart';
import 'package:car_renting_system/searchauth.dart';
import 'package:car_renting_system/searchselected.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String Address = "";

  var gmail;
  Future request2(var email) async {
    print(email);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    var email2 = currentUser!.email;
    print(email2);
    var collection = FirebaseFirestore.instance.collection('add-trip');
    var docSnapshot = await collection.doc(currentUser.email).get();
    Map<String, dynamic>? data = docSnapshot.data();
    var _list = data!.values.toList();
    print("request2");
    print(_list[6]);
    var em = _list[3];
    //print(data["pic-up-date"]);

    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("request");
    return collectionRef.doc(em).set({
      "send-req": email2,
      "received-req": email,
    }).catchError((error) => print("somethimg is wrong. $error"));
  }

  Future request(var email) async {
    print(email);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    var email2 = currentUser!.email;
    print(email2);
    var collection = FirebaseFirestore.instance.collection('add-trip');
    var docSnapshot = await collection.doc(currentUser.email).get();
    Map<String, dynamic>? data = docSnapshot.data();
    var _list = data!.values.toList();
    print(_list);
    //print(data["pic-up-date"]);

    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("add-trip");
    return collectionRef.doc(currentUser.email).update({
      "send-req": email2,
      "received-req": email,
    }).catchError((error) => print("somethimg is wrong. $error"));
  }

  // _reference.get()  ---> returns Future<QuerySnapshot>
  //_reference.snapshots()--> Stream<QuerySnapshot> -- realtime updates
  late Stream<QuerySnapshot> _stream;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Card(
        child: TextField(
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search), hintText: 'Search by Address...'),
          onChanged: (val) {
            setState(() {
              Address = val;
            });
          },
        ),
      )),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("car-owner").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Something is wrong"),
            );
          }
          print("address = ");
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
                var email = _documentSnapshot['email'];
                var address = _documentSnapshot['address'];

                print(email);
                gmail = email;

                if (Address.isEmpty) {
                  return GestureDetector(
                    onTap: () {
                      SearchAuth c1 = new SearchAuth();
                      print("search $email");
                      c1.emailGet(email);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchSelected(
                              text: email,
                            ),
                          ));
                    },
                    child: Card(
                      color: Colors.white70,
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                //backgroundColor: Colors.white,
                                width: MediaQuery.of(context).size.width * .08,
                                child: Image.network(
                                    'https://img.freepik.com/premium-vector/car-logo-design-simple-modern-concept-vector-eps-10_567423-203.jpg?w=826'), //Text
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .8,
                                child: ListTile(
                                  title: Text(
                                    "${_documentSnapshot['companyName']}",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      //fontStyle: FontStyle.italic,

                                      //backgroundColor: Colors.blue,
                                    ),
                                  ),
                                  subtitle: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Address: $address",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              //fontStyle: FontStyle.italic,

                                              //backgroundColor: Colors.blue,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (_documentSnapshot['address']
                    .toString()
                    .toLowerCase()
                    .startsWith(Address.toLowerCase())) {
                  return GestureDetector(
                    onTap: () {
                      SearchAuth c1 = new SearchAuth();
                      print("search $email");
                      c1.emailGet(email);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchSelected(
                              text: email,
                            ),
                          ));
                    },
                    child: Card(
                      color: Colors.white70,
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                //backgroundColor: Colors.white,
                                width: MediaQuery.of(context).size.width * .08,
                                child: Image.network(
                                    'https://img.freepik.com/premium-vector/car-logo-design-simple-modern-concept-vector-eps-10_567423-203.jpg?w=826'), //Text
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .8,
                                child: ListTile(
                                  title: Text(
                                    "${_documentSnapshot['companyName']}",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      //fontStyle: FontStyle.italic,

                                      //backgroundColor: Colors.blue,
                                    ),
                                  ),
                                  subtitle: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Address: $address",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              //fontStyle: FontStyle.italic,

                                              //backgroundColor: Colors.blue,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              });
        },
      )), //Display a list // Add a FutureBuilder
    );
  }
}
