import 'package:car_renting_system/ratingCheck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Trip extends StatefulWidget {
  const Trip({Key? key}) : super(key: key);

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  @override
  Widget build(BuildContext context) {
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
    var _rating = 0.0;
    var acceptBy;
    var currentuser;

    ratingAlgo() async {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      var currentUser = _auth.currentUser;
      currentuser = currentUser?.email;
      var collection = FirebaseFirestore.instance.collection('Add-Car');
      var docSnapshot =
          await collection.doc(acceptBy).collection('add').doc(ID).get();
      //Map<String, dynamic>?
      var data = docSnapshot.data();
      var _list = data!.values.toList();
      var count = data['count'];
      var rating = data['total-rate'];
      print("count = $count rating = $rating");
      count++;
      rating = rating + _rating;
      int rateCar = rating ~/ count;
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection("Add-Car");
      print(currentUser?.email);

      return _collectionRef.doc(acceptBy).collection('add').doc(ID).update({
        "total-rate": rating,
        "count": count,
        "rate-car": rateCar,
      }).catchError((error) => print("somethimg is wrong. $error"));
    }

    return Scaffold(
      backgroundColor: Color(0xFFb1c4d2),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("trip-history")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection('trip')
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
                  return Card(
                    color: Colors.white,
                    elevation: 10,
                    child: Container(
                      decoration: myBoxDecoration(),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "Accept By: ${_documentSnapshot['accept-by']}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Pic Up Location: ${_documentSnapshot['pic-up-loc']}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Drop Off Loc:  ${_documentSnapshot['drop-off-loc']}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Pic Up Time:  ${_documentSnapshot['pic-up-time']}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Drop Off Time:  ${_documentSnapshot['drop-off-time']}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) async {
                              print(rating);

                              acceptBy = _documentSnapshot['accept-by'];
                              _rating = rating;
                              ID = _documentSnapshot['car-ID'];
                              ratingAlgo();
                              //Ratingcheck(acceptBy, ID, currentuser);
                            },
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
