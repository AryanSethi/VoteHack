import 'package:VoteHack/screens/commingSoon.dart';
import 'package:flutter/material.dart';
import 'package:VoteHack/variable.dart' as variable;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Notify extends StatefulWidget {
  final userId;
  Notify({this.userId});
  @override
  _Notify createState() => _Notify();
}

class _Notify extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance
              .collection("candidates")
              .doc(widget.userId)
              .updateData({
            "notify": variable.getNotify,
          }).then((_) {
            print("success!");
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (context) => ComingSoon()),
                (route) => false);
          });
        },
        child: Icon(Icons.arrow_forward),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Align(
              alignment: Alignment.topRight,
              child: Switch(
                value: variable.getNotify,
                onChanged: (value) {
                  setState(() {
                    variable.getNotify = value;
                    print(variable.getNotify);
                  });
                },
                activeTrackColor: Colors.orange,
                activeColor: Colors.deepOrangeAccent,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(50),
                child: Image.asset('assets/notification.png')),
            SizedBox(height: 30),
            Text(
              "Turn Notification ON to get notify on Election Day",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      )),
    );
  }
}
