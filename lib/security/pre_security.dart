import 'package:VoteHack/screens/commingSoon.dart';
import 'package:VoteHack/screens/notification.dart';
import 'package:VoteHack/security/security1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:VoteHack/variable.dart' as variable;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class PreSecurity extends StatefulWidget {
  @override
  _PreSecurity createState() => _PreSecurity();
}

class _PreSecurity extends State<PreSecurity> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformImei;
    String idunique;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      List<String> multiImei = await ImeiPlugin.getImeiMulti();
      print(multiImei);
      idunique = await ImeiPlugin.getId();
    } on PlatformException {
      platformImei = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      variable.mobileImei = platformImei;
      variable.uniqueId = idunique;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.orange,
        title: Text("Vote Hack"), //* Change this to something less cliche
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Antu_yast-security.svg/600px-Antu_yast-security.svg.png"))),
            ),
            SizedBox(height: 100),
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
                  controller: variable.secretId,
                  decoration: InputDecoration(
                      hintText: 'Enter UID',
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(height: 30),
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
                  controller: variable.phoneNumber,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
                height: 80,
                width: 80,
                child: variable.progressBar
                    ? Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              size: 40,
                            ),
                            onPressed: () {
                              setState(() {
                                variable.progressBar = true;
                              });
                              //this block is for check controller value
                              if (variable.phoneNumber.text != "" &&
                                  variable.secretId.text != "") {
                                Firestore.instance
                                    .collection("candidates")
                                    .doc(variable.secretId.text)
                                    .get()
                                    .then((value) {
                                  var data = value.data();
                                  //checking correct phone number
                                  if (data["phone"] ==
                                      variable.phoneNumber.text) {
                                    Fluttertoast.showToast(
                                        msg: "Please Wait",
                                        toastLength: Toast.LENGTH_SHORT);
                                    //user imei number is enter or not
                                    if (data["imei"] == null) {
                                      if (variable.mobileImei != "Unknown") {
                                        Firestore.instance
                                            .collection("candidates")
                                            .doc(variable.secretId.text)
                                            .updateData({
                                          "imei":
                                              variable.mobileImei.toString(),
                                        }).then((_) {
                                          print("success!");
                                          if (data["notify"] == false &&
                                              data["electionDate"] == "") {
                                            Navigator.pop(context);
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        Notify(
                                                          userId: variable
                                                              .secretId.text,
                                                        )),
                                                (route) => false);
                                          } else if (data["notify"] == true &&
                                              data["electionDate"] == "") {
                                            Navigator.pop(context);
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        ComingSoon()),
                                                (route) => false);
                                          } else if (data["notify"] == false &&
                                              data["electionDate"] != "") {
                                            Navigator.pop(context);
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        PreSecurity()),
                                                (route) => false);
                                          } else if (data["notify"] == true &&
                                              data["electionDate"] != "") {
                                            Navigator.pop(context);

                                            //for navigation we have to match current date and election date
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        Security1()),
                                                (route) => false);
                                          }

                                          setState(() {
                                            variable.progressBar = false;
                                          });
                                        });
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Please Try Again",
                                            toastLength: Toast.LENGTH_SHORT);
                                        setState(() {
                                          variable.progressBar = false;
                                        });
                                        initPlatformState();
                                      }
                                    } else {
                                      //checking that user logging from same device or not

                                      if (data["imei"] == variable.mobileImei) {
                                        // Navigator.pop(context);
                                        // Navigator.pushAndRemoveUntil(
                                        //     context,
                                        //     CupertinoPageRoute(
                                        //         builder: (context) => Notify(
                                        //               userId: variable
                                        //                   .secretId.text,
                                        //             )),
                                        //     (route) => false);
                                        if (data["notify"] == false &&
                                            data["electionDate"] == "") {
                                          Navigator.pop(context);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) => Notify(
                                                        userId: variable
                                                            .secretId.text,
                                                      )),
                                              (route) => false);
                                        } else if (data["notify"] == true &&
                                            data["electionDate"] == "") {
                                          Navigator.pop(context);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      ComingSoon()),
                                              (route) => false);
                                        } else if (data["notify"] == false &&
                                            data["electionDate"] != "") {
                                          Navigator.pop(context);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      PreSecurity()),
                                              (route) => false);
                                        } else if (data["notify"] == true &&
                                            data["electionDate"] != "") {
                                          Navigator.pop(context);
                                          //for navigation we have to match current date and election date
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      Security1()),
                                              (route) => false);
                                        }
                                        setState(() {
                                          variable.progressBar = false;
                                        });
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Logged in with Correct Phone",
                                            toastLength: Toast.LENGTH_SHORT);
                                        setState(() {
                                          variable.progressBar = false;
                                        });
                                      }
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Wrong Phone Number",
                                        toastLength: Toast.LENGTH_SHORT);
                                    setState(() {
                                      variable.progressBar = false;
                                    });
                                  }
                                }).catchError((onError) {
                                  Fluttertoast.showToast(
                                      msg: "User Id Wrong",
                                      toastLength: Toast.LENGTH_SHORT);
                                  setState(() {
                                    variable.progressBar = false;
                                  });
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Enter Full Details",
                                    toastLength: Toast.LENGTH_SHORT);
                                setState(() {
                                  variable.progressBar = false;
                                });
                              }
                            }),
                      ))
          ],
        ),
      )),
    );
  }
}
