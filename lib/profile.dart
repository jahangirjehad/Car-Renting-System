import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var name;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("user-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "user-name": _nameController.text,
      "password": _passController.text,
    });
  }

  setData(data) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.greenAccent[400],
          radius: 100,
          child: Image.network(
              'https://pic.onlinewebfonts.com/svg/img_550783.png'), //Text
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * .3,
                child: Text(
                  "Old Name: ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
            Container(
              width: MediaQuery.of(context).size.width * .55,
              child: Text(
                "$name",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * .3,
                child: Text(
                  "Change Name: ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
            Container(
              width: MediaQuery.of(context).size.width * .55,
              child: TextFormField(
                controller: _nameController,
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
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * .3,
                child: Text(
                  "Change Pass: ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
            Container(
              width: MediaQuery.of(context).size.width * .55,
              child: TextFormField(
                controller: _passController,
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
                  hintStyle: const TextStyle(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () => updateData(),
          child: Text("Update Data"),
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
            onPrimary: Colors.white,
            textStyle: TextStyle(
                color: Colors.black, fontSize: 30, fontStyle: FontStyle.normal),
            minimumSize: Size(100, 50),
            padding: EdgeInsets.all(20),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[400],
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("user-form-data")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                var data = snapshot.data;
                if (data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                name = data['user-name'];
                return setData(data);
              },
            ),
          ),
        )),
      ),
    );
  }
}
