import 'dart:async';
import 'package:car_renting_system/Login.dart';
import 'package:car_renting_system/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:car_renting_system/Screen.dart';
import 'package:car_renting_system/Myregister.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailControl = TextEditingController();
  TextEditingController _passControl = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _catagory = TextEditingController();
  TextEditingController _companyName = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  String? catagory;
  String? check = "Passenger";
  Future carowner() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("car-owner");
    print("Owner created");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
          "user-name": _userNameController.text,
          "email": _emailControl.text,
          "companyName": _companyName.text,
          "address": _addressController.text,
        })
        .then((value) => Navigator.pushNamed(context, 'login'))
        .catchError((error) => print("somethimg is wrong. $error"));
  }

  sendData() async {
    if (_catagory != check) {
      carowner();
    }
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("user-form-data");
    print("created");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
          "user-name": _userNameController.text,
          "email": _emailControl.text,
          "catagory": catagory,
          "password": _passControl.text,
        })
        .then((value) => Navigator.pushNamed(context, 'login'))
        .catchError((error) => print("somethimg is wrong. $error"));
  }

  signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailControl.text,
        password: _passControl.text,
      );
      var authCredential = userCredential.user;
      print(authCredential!.email);
      if (authCredential.uid.isNotEmpty) {
        // ignore: use_build_context_synchronously
        sendData();
      } else {
        Fluttertoast.showToast(msg: 'Something is Wrong');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "Weak Password");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "The email already exists.");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.greenAccent[400],
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          elevation: 0,
        ),
        //backgroundColor: Colors.blue,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "Create\nAccount",
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.27),
              child: Column(children: [
                TextField(
                  controller: _emailControl,
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
                    hintText: 'Email',
                    hintStyle: const TextStyle(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _passControl,
                  obscureText: true,
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
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _userNameController,
                  //obscureText: true,
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
                    hintText: 'User_Name',
                    hintStyle: const TextStyle(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _addressController,
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
                    hintText: 'Address',
                    hintStyle: const TextStyle(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Text(
                      "Catagory: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Divider(),
                    RadioListTile(
                      activeColor: Colors.white,
                      title: Text(
                        "Passenger",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      value: "Passenger",
                      groupValue: catagory,
                      onChanged: (value) {
                        setState(() {
                          catagory = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      activeColor: Colors.white,
                      title: Text(
                        "Car Rent Center",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      value: "CarRentCenter",
                      groupValue: catagory,
                      onChanged: (value) {
                        setState(() {
                          catagory = value.toString();
                        });
                      },
                    ),
                  ],
                ),
                TextField(
                  controller: _companyName,
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
                    hintText: 'Company Name',
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xff4c505b),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            signUp();
                            Navigator.pushNamed(context, 'login');
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
