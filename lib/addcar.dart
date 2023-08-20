import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'firebase_api.dart';
import 'getCar.dart';

class AddCar extends StatefulWidget {
  const AddCar({Key? key}) : super(key: key);

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  TextEditingController _catagory = TextEditingController();
  String? catagory;
  TextEditingController carName = TextEditingController();
  TextEditingController seatNumber = TextEditingController();
  UploadTask? task;
  File? file;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;
  late var imgDownload;

  Future selectFile() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.getImage(source: ImageSource.gallery);
      final pickedImageFile = File(pickedImage!.path);
      setState(() {
        _pickedImage = pickedImageFile;
        file = pickedImageFile;
      });
    } catch (err) {
      print("exception");
      print(err);
    }
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files//$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    imgDownload = urlDownload;

    print('Download-Link: $urlDownload');
  }

  sendData() async {
    int rate = 0;
    int count = 0;
    int ratecar = 0;
    print(imgDownload);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("Add-Car");
    print(currentUser?.email);
    print(_collectionRef);
    return _collectionRef.doc(currentUser!.email).collection('add').doc().set({
      "car-name": carName.text,
      "seat-no": seatNumber.text,
      "catagory": catagory,
      "img": imgDownload,
      "total-rate": rate,
      "count": count,
      "rate-car": ratecar,
      "status": "Available",
    }).catchError((error) => print("somethimg is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
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
            controller: carName,
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
              hintText: 'Car Name',
              hintStyle: const TextStyle(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: seatNumber,
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
              hintText: 'No of seat',
              hintStyle: const TextStyle(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              selectFile();
            },
            child: Text("Add Image"),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontStyle: FontStyle.normal),
              minimumSize: Size(50, 50),
              padding: EdgeInsets.all(10),
            ),
          ),
          SizedBox(height: 8),
          Text(
            fileName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          ElevatedButton(
            onPressed: () {
              uploadFile();
            },
            child: Text("Upload Image"),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontStyle: FontStyle.normal),
              minimumSize: Size(50, 50),
              padding: EdgeInsets.all(10),
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
                  "AC",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                value: "AC",
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
                  "Non-AC",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                value: "Non-AC",
                groupValue: catagory,
                onChanged: (value) {
                  setState(() {
                    catagory = value.toString();
                  });
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              sendData();
              //GetCar().request();
            },
            child: Text("Add Car"),
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
