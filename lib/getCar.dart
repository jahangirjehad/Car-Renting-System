import 'package:car_renting_system/addcar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetCar {
  Future request() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    var collection = FirebaseFirestore.instance.collection('Add-Car');
    var collection2 = FirebaseFirestore.instance
        .collection('Add-Car')
        .doc(currentUser!.email)
        .collection('add');

    var docSnapshot =
        await collection.doc(currentUser.email).collection('add').doc().get();
    Map<String, dynamic>? data = docSnapshot.data();
    print(data);
    //print(data["pic-up-date"]);
  }
}
