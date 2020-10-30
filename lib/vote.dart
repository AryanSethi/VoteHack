import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        elevation: 4.0,
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
            "A Vote for a better Nation"), //* Change this to something less cliche
      ),
      body: Column(
        children: [
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
      width: double.infinity,
      child: FlatButton(
        color: Colors.orange,
        child: Text("Submit Vote"),
        onPressed: () {

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
          return CircularProgressIndicator();
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return RadioListTile<int>(
              value: index,
              groupValue: _selected,
              title: Text(ds.id),
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
