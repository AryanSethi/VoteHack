import 'dart:developer';

import 'package:VoteHack/security/pre_security.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:VoteHack/variable.dart' as variable;
import 'package:fluttertoast/fluttertoast.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreen createState() => _LockScreen();
}

TextEditingController one = TextEditingController();
TextEditingController two = TextEditingController();
TextEditingController three = TextEditingController();
TextEditingController four = TextEditingController();

class _LockScreen extends State<LockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Vote Hack",
          style: TextStyle(
              color: Colors.black, fontFamily: "Quicksand", fontSize: 30),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.black,
              ),
              onPressed: () async {
                await variable.deletePassword();
                Fluttertoast.showToast(
                    msg: "Password Deleted", toastLength: Toast.LENGTH_SHORT);
              })
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Image.asset('assets/passcode.png'),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                textField(
                    variable.pin1, variable.focus2, variable.focus1, context),
                textField(
                    variable.pin2, variable.focus3, variable.focus2, context),
                textField(
                    variable.pin3, variable.focus4, variable.focus3, context),
                textField(
                    variable.pin4, variable.focus5, variable.focus4, context),
              ],
            ),
            SizedBox(height: 40),
            Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(colors: variable.colorMain),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: Offset(1, 5),
                        blurRadius: 5.0,
                        spreadRadius: 1.0)
                  ],
                ),
                child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(50.0),
                    // ),
                    child: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () async {
                          if (variable.pin1.text != "" &&
                              variable.pin2.text != "" &&
                              variable.pin3.text != "" &&
                              variable.pin4.text != "") {
                            String password = await variable.getDate();
                            log(password);
                            String myPass = variable.pin1.text +
                                variable.pin2.text +
                                variable.pin3.text +
                                variable.pin4.text;
                            if (password == '') {
                              Fluttertoast.showToast(
                                  msg: "Please Wait",
                                  toastLength: Toast.LENGTH_SHORT);
                              await variable.imputPref(
                                  variable.pin1.text,
                                  variable.pin2.text,
                                  variable.pin3.text,
                                  variable.pin4.text);
                              Fluttertoast.showToast(
                                  msg: "Password Set",
                                  toastLength: Toast.LENGTH_SHORT);
                            } else {
                              if (myPass == password) {
                                variable.pin1.clear();
                                variable.pin2.clear();
                                variable.pin3.clear();
                                variable.pin4.clear();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => PreSecurity()),
                                    (route) => false);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Wrong Passowrd",
                                    toastLength: Toast.LENGTH_SHORT);
                                variable.pin1.clear();
                                variable.pin2.clear();
                                variable.pin3.clear();
                                variable.pin4.clear();
                              }
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Enter the Whole Text",
                                toastLength: Toast.LENGTH_SHORT);
                            variable.pin1.clear();
                            variable.pin2.clear();
                            variable.pin3.clear();
                            variable.pin4.clear();
                          }
                        })))
          ],
        ),
      )),
    );
  }
}

Widget textField(TextEditingController controller, FocusNode fnode,
    FocusNode cnode, BuildContext context) {
  return Container(
    margin: EdgeInsets.all(1.0),
    width: MediaQuery.of(context).size.width / 5,
    height: MediaQuery.of(context).size.height / 10,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(colors: variable.colorMain)),
    child: Center(
      child: TextField(
        obscureText: true,
        focusNode: cnode,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25.0, color: Colors.white),
        onChanged: (value) {
          FocusScope.of(context).requestFocus(fnode);
        },
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(border: InputBorder.none, counterText: ""),
      ),
    ),
  );
}
