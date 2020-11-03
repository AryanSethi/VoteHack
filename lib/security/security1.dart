import 'dart:math';

import 'package:VoteHack/vote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:VoteHack/variable.dart' as variable;
import 'package:sms/sms.dart';

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
              padding: EdgeInsets.all(40),
              child: Container(child: Image.asset('assets/mobile.png')),
            ),
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
                  controller: variable.phones,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      hintStyle: TextStyle(fontFamily: "Quicksand"),
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
                      onPressed: () async {
                        Fluttertoast.showToast(
                            msg: "OTP Funtionality",
                            toastLength: Toast.LENGTH_SHORT);
                        await variable.sendOtp(variable.phones.text);
                        showAlertDialog(context, variable.phones.text);
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

showAlertDialog(BuildContext context, number) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () async {
      Fluttertoast.showToast(
          msg: "Please Wait", toastLength: Toast.LENGTH_SHORT);
      int otpValue = int.parse(variable.otp.text);
      bool checker = await variable.resultChecker(otpValue);
      if (checker) {
        // Navigator.push(
        //     context, CupertinoPageRoute(builder: (context) => Vote()));
        Navigator.pushAndRemoveUntil(context,
            CupertinoPageRoute(builder: (context) => Vote()), (route) => false);
        variable.otp.clear();
      } else {
        Fluttertoast.showToast(
            msg: "Enter Correct OTP", toastLength: Toast.LENGTH_SHORT);
      }
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Enter OTP"),
    content: TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 4,
      style: TextStyle(color: Color.fromRGBO(38, 50, 56, .50)),
      controller: variable.otp,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(//this has no effect
              ),
          borderRadius: BorderRadius.circular(40.0),
        ),
        hintText: 'Enter OTP',
        hintStyle: TextStyle(
          color: Color.fromRGBO(38, 50, 56, 0.30),
          fontSize: 15.0,
          fontFamily: "Poppins",
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
