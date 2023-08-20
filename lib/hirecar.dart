import 'dart:async';

import 'package:car_renting_system/mapping.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:location/location.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

class HireCar extends StatefulWidget {
  const HireCar({Key? key}) : super(key: key);

  @override
  State<HireCar> createState() => _HireCarState();
}

class _HireCarState extends State<HireCar> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  String? _setTime;
  String? _hour, _minute, _time;
  String? dateTime;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController pickUpDate = TextEditingController();
  TextEditingController returnDate = TextEditingController();
  TextEditingController pickUpTime = TextEditingController();
  TextEditingController returnTime = TextEditingController();
  TextEditingController picupLoc = TextEditingController();
  TextEditingController returnLoc = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future addtrip() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("add-trip");
    return collectionRef.doc(currentUser!.email).set({
      "pic-up-loc": picupLoc.text,
      "return-loc": returnLoc.text,
      "pic-up-date": pickUpDate.text,
      "return-date": returnDate.text,
      "pic-uo-time": pickUpTime.text,
      "return-time": returnTime.text,
    }).catchError((error) => print("somethimg is wrong. $error"));
  }

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        pickUpDate.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectDateFromPicker2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        returnDate.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        pickUpTime.text = _time!;
        pickUpTime.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  Future<Null> _selectTime2(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        returnTime.text = _time!;
        returnTime.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    //final applicationBlock = Provider.of<ApplicationBlock>(context);
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: (MediaQuery.of(context).size.width),
              height: 2000,
              padding: new EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.network(
                      'https://c7.alamy.com/comp/T8P424/vector-logo-for-car-rental-and-sales-T8P424.jpg',
                      height: 200,
                      width: 500,
                    ),
                    const ListTile(
                      title: Text('Start a Reservation',
                          style: TextStyle(fontSize: 30.0)),
                      subtitle: Text('*indicate required field',
                          style: TextStyle(fontSize: 18.0)),
                    ),
                    TextField(
                      controller: picupLoc,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          color: Colors.white,
                          onPressed: () {},
                          icon: Icon(
                            Icons.location_searching_sharp,
                            color: Colors.black,
                          ),
                        ),
                        //prefixIcon: Icon(Icons.timer),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        labelText: 'pick-up-Location *',
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 30),
                      maxLines: 1,
                      minLines: 1,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: returnLoc,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          color: Colors.white,
                          onPressed: () {},
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                        ),
                        //prefixIcon: Icon(Icons.timer),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        labelText: 'Drop-Off-Location *',
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 30),
                      maxLines: 1,
                      minLines: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 300,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(22.3569, 91.7832), zoom: 14.245),
                        mapType: MapType.normal,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        myLocationEnabled: true,
                        compassEnabled: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width) * .40,
                              child: TextField(
                                controller: pickUpDate,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      _selectDateFromPicker(context);
                                    },
                                    icon: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                  //prefixIcon: Icon(Icons.timer),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  labelText: 'pick-up-date',
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(fontSize: 20),
                                maxLines: 1,
                                minLines: 1,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width) * .40,
                              child: TextField(
                                controller: pickUpTime,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      _selectTime(context);
                                    },
                                    icon: Icon(
                                      Icons.timer,
                                      color: Colors.black,
                                    ),
                                  ),
                                  //prefixIcon: Icon(Icons.timer),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  labelText: 'pick-up-time',
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(fontSize: 20),
                                maxLines: 1,
                                minLines: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            //Text("pic-Up_Date"),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width) * .40,
                              child: TextField(
                                controller: returnDate,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      _selectDateFromPicker2(context);
                                    },
                                    icon: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                  //prefixIcon: Icon(Icons.timer),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  labelText: 'return-date',
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(fontSize: 20),
                                maxLines: 1,
                                minLines: 1,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width) * .40,
                              child: TextField(
                                controller: returnTime,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      _selectTime2(context);
                                    },
                                    icon: Icon(
                                      Icons.timer,
                                      color: Colors.black,
                                    ),
                                  ),
                                  //prefixIcon: Icon(Icons.timer),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  labelText: 'return-time',
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(fontSize: 20),
                                maxLines: 1,
                                minLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          addtrip();
                          Navigator.pushNamed(context, 'search');
                        },
                        child: Text("Search"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellowAccent,
                          onPrimary: Colors.black,
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
