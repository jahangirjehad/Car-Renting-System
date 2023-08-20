import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddDriver extends StatefulWidget {
  const AddDriver({Key? key}) : super(key: key);

  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  TextEditingController driverName = TextEditingController();
  TextEditingController driverAge = TextEditingController();
  sendData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("Add-driver");
    print("created");
    return _collectionRef
        .doc(currentUser!.email)
        .collection('add-driver')
        .doc()
        .set({
      "driver-name": driverName.text,
      "driver-age": driverAge.text,
    }).catchError((error) => print("somethimg is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[400],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Rent a Car and Drive Happy",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          //textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: driverName,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              hintText: 'Driver Name',
              hintStyle: const TextStyle(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: driverAge,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              hintText: 'Driver Age',
              hintStyle: const TextStyle(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              sendData();
            },
            child: Text("Add Driver"),
            style: ElevatedButton.styleFrom(
              primary: Colors.teal,
              onPrimary: Colors.white,
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontStyle: FontStyle.normal),
              minimumSize: Size(100, 50),
              padding: EdgeInsets.all(20),
            ),
          )
        ],
      ),
    );
  }
}
