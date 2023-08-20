import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateCar extends StatefulWidget {
  const UpdateCar({Key? key}) : super(key: key);

  @override
  State<UpdateCar> createState() => _UpdateCarState();
}

class _UpdateCarState extends State<UpdateCar> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _seatController = TextEditingController();
  TextEditingController _catagoryController = TextEditingController();
  var name, seat, cate;
  updateData(id) {
    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection("Add-Car")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('add');
    print(FirebaseAuth.instance.currentUser!.email);
    print("id=$id");
    //var name = ;
    // print("name$name");
    return _collectionRef.doc(id).update({
      "car-name": _nameController.text,
      "catagory": _catagoryController.text,
      "seat-no": _seatController.text,
    }).catchError((error) => print("somethimg is wrong. $error"));
  }

  Future deleteData(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("Add-Car")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("add")
          .doc(id)
          .delete();
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000e4b),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                    name = _documentSnapshot['car-name'];
                    seat = _documentSnapshot['seat-no'];
                    cate = _documentSnapshot['catagory'];

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
                                height: 40,
                                child: Text(
                                  "Car Name: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width * .5,
                                height: 30,
                                child: Text("$name"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 7),
                                //color: Colors.greenAccent,
                                //margin: EdgeInsets.only(bottom: 5),
                                width: MediaQuery.of(context).size.width * .3,
                                height: 40,
                                child: Text(
                                  "Change Name: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width * .5,
                                height: 40,
                                child: TextFormField(
                                  maxLines: 1,
                                  controller: _nameController,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    hintText: 'Car_Name',
                                    hintStyle: const TextStyle(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 7),
                                //color: Colors.greenAccent,
                                //margin: EdgeInsets.only(bottom: 5),
                                width: MediaQuery.of(context).size.width * .3,
                                height: 40,
                                child: Text(
                                  "Old Seat No: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width * .5,
                                height: 30,
                                child: Text("$seat"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 7),
                                //color: Colors.greenAccent,
                                //margin: EdgeInsets.only(bottom: 5),
                                width: MediaQuery.of(context).size.width * .3,
                                height: 40,
                                child: Text(
                                  "Change Seat: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width * .5,
                                height: 40,
                                child: TextFormField(
                                  maxLines: 1,
                                  controller: _seatController,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    hintText: 'Update_Seat',
                                    hintStyle: const TextStyle(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 7),
                                //color: Colors.greenAccent,
                                //margin: EdgeInsets.only(bottom: 5),
                                width: MediaQuery.of(context).size.width * .3,
                                height: 40,
                                child: Text(
                                  "Category: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width * .5,
                                height: 30,
                                child: Text("$cate"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 7),
                                //color: Colors.greenAccent,
                                //margin: EdgeInsets.only(bottom: 5),
                                width: MediaQuery.of(context).size.width * .3,
                                height: 40,
                                child: Text(
                                  "Change Category: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width * .5,
                                height: 40,
                                child: TextFormField(
                                  maxLines: 1,
                                  controller: _catagoryController,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    hintText: 'Category',
                                    hintStyle: const TextStyle(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * .4,
                                margin: EdgeInsets.only(left: 10, bottom: 25),
                                child: ElevatedButton(
                                  onPressed: () {
                                    var collection = FirebaseFirestore.instance
                                        .collection('Add-Car');
                                    collection
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                        .collection('add')
                                        .doc(_documentSnapshot
                                            .id) // <-- Doc ID where data should be updated.
                                        .update({
                                          "car-name": _nameController.text,
                                          "catagory": _catagoryController.text,
                                          "seat-no": _seatController.text,
                                        }) // <-- Updated data
                                        .then((_) => print('Updated'))
                                        .catchError((error) =>
                                            print('Update failed: $error'));
                                    Fluttertoast.showToast(
                                        msg: 'Successfully Up To Date');
                                  },
                                  child: Text("Update Data"),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.teal,
                                    onPrimary: Colors.white,
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal),
                                    //minimumSize: Size(100, 50),
                                    //padding: EdgeInsets.all(20),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .3,
                                margin: EdgeInsets.only(left: 40, bottom: 25),
                                child: ElevatedButton(
                                  onPressed: () {
                                    final collection = FirebaseFirestore
                                        .instance
                                        .collection('Add-Car');
                                    collection
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                        .collection('add')
                                        .doc(_documentSnapshot
                                            .id) // <-- Doc ID to be deleted.
                                        .delete() // <-- Delete
                                        .then((_) => print('Deleted'))
                                        .catchError((error) =>
                                            print('Delete failed: $error'));
                                    Fluttertoast.showToast(
                                        msg: 'The Car is Removed');
                                  },
                                  child: Text("remove"),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    onPrimary: Colors.white,
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontStyle: FontStyle.normal),
                                    // minimumSize: Size(100, 50),
                                    // padding: EdgeInsets.all(20),
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
      )),
    );
  }
}
