import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OwnerProfile extends StatefulWidget {
  const OwnerProfile({Key? key}) : super(key: key);

  @override
  State<OwnerProfile> createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _companyName = TextEditingController();
  TextEditingController _address = TextEditingController();
  var name, address, company;
  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("car-owner");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "user-name": _nameController.text,
      "companyName": _companyName.text,
      "address": _address.text,
    });
  }

  setData(data) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * .3,
                child: Text(
                  "Name: ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                )),
            Container(
              width: MediaQuery.of(context).size.width * .55,
              child: Text(
                "$name",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
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
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * .3,
                child: Text(
                  "Company Name: ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                )),
            Container(
              width: MediaQuery.of(context).size.width * .55,
              child: Text(
                "$company",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                )),
            Container(
              width: MediaQuery.of(context).size.width * .55,
              child: TextFormField(
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
                  hintText: 'Company_Name',
                  hintStyle: const TextStyle(),
                ),
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
                  "address: ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width * .55,
              child: Text(
                "$address",
                style: TextStyle(
                  fontSize: 20,
                ),
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
                  "Change Address: ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width * .55,
              child: TextFormField(
                controller: _address,
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
                  hintText: 'address',
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
          onPressed: () {
            updateData();
          },
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
                  .collection("car-owner")
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
                address = data['address'];
                company = data['companyName'];
                return setData(data);
              },
            ),
          ),
        )),
      ),
    );
  }
}
