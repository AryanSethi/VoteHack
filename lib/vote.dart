import 'package:VoteHack/screens/greeting.dart';
import 'package:VoteHack/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Vote extends StatefulWidget {
  static final id = 'Vote';

  @override
  _VoteState createState() => _VoteState();
}

class _VoteState extends State<Vote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "A Vote for a better Nation",
          style: TextStyle(
              fontFamily: "Quicksand", color: Colors.black, fontSize: 25),
        ), //* Change this to something less cliche
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Image.asset('assets/vote.png'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              thickness: 3,
            ),
          ),
          Expanded(child: VoterSelection()),
          SubmitButton(),
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors: colorMain)),
      width: double.infinity,
      height: 50,
      child: FlatButton(
        child: Text(
          "Submit Vote",
          style: TextStyle(
              fontFamily: "Quicksand", color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Fluttertoast.showToast(
              msg: "Your Vote is Done", toastLength: Toast.LENGTH_SHORT);
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Greeting()));
        },
      ),
    );
  }
}

class VoterSelection extends StatefulWidget {
  @override
  _VoterSelectionState createState() => _VoterSelectionState();
}

class _VoterSelectionState extends State<VoterSelection> {
  final _collection = FirebaseFirestore.instance.collection('politicianparty');

  int _selected = -1;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _collection.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return RadioListTile<int>(
              value: index,
              groupValue: _selected,
              title: Text(
                ds.id,
                style: TextStyle(fontFamily: "Quicksand"),
              ),
              onChanged: (int selection) {
                setState(() {
                  _selected = selection;
                });
              },
            );
          },
          itemCount: snapshot.data.docs.length,
        );
      },
    );
  }
}
