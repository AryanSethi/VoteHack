import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Security1 extends StatefulWidget {
  @override
  _Security1 createState() => _Security1();
}

class _Security1 extends State<Security1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1,
                        color: Colors.grey,
                        style: BorderStyle.solid)),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
                height: 80,
                width: 80,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "OTP Funtionality",
                            toastLength: Toast.LENGTH_SHORT);
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                        size: 40,
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
