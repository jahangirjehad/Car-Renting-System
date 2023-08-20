import 'package:flutter/material.dart';

class OwnerHome extends StatefulWidget {
  const OwnerHome({Key? key}) : super(key: key);

  @override
  State<OwnerHome> createState() => _OwnerHomeState();
}

class _OwnerHomeState extends State<OwnerHome> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(width);
    print(height);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'add-car');
                  },
                  child: Container(
                    width: width * .40,
                    height: height * .20,
                    margin: EdgeInsets.only(
                        left: width * .01,
                        top: 30,
                        right: width * .08,
                        bottom: 0),
                    //padding: new EdgeInsets.only(left: 10, top: 150),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blue,
                      elevation: 2,
                      child: Center(
                        child: Text(
                          "ADD CAR",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'add-driver');
                  },
                  child: Container(
                    width: width * .40,
                    height: height * .20,
                    margin: EdgeInsets.only(
                        left: width * .01,
                        top: 30,
                        right: width * .01,
                        bottom: 0),
                    //padding: new EdgeInsets.only(left: 10, top: 150),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blue,
                      elevation: 2,
                      child: Center(
                        child: Text(
                          " ADD DRIVER",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'car-on-trip');
                  },
                  child: Container(
                    width: width * .40,
                    height: height * .20,
                    margin: EdgeInsets.only(
                        left: width * .01,
                        top: 30,
                        right: width * .08,
                        bottom: 0),
                    //padding: new EdgeInsets.only(left: 10, top: 150),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blue,
                      elevation: 2,
                      child: Center(
                        child: Text(
                          "   CAR ON TRIP",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'add-driver');
                  },
                  child: Container(
                    width: width * .40,
                    height: height * .20,
                    margin: EdgeInsets.only(
                        left: width * .01,
                        top: 30,
                        right: width * .01,
                        bottom: 0),
                    //padding: new EdgeInsets.only(left: 10, top: 150),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blue,
                      elevation: 2,
                      child: Center(
                        child: Text(
                          "AVAILABLE CAR",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'update-car');
                    },
                    child: Container(
                      width: width * .40,
                      height: height * .20,
                      margin: EdgeInsets.only(
                          left: width * .01,
                          top: 30,
                          right: width * .08,
                          bottom: 0),
                      //padding: new EdgeInsets.only(left: 10, top: 150),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.blue,
                        elevation: 2,
                        child: Center(
                          child: Text(
                            "UPDATE CAR",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
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
}
