import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fundee/Screen/Patient/patient_menu_screen.dart';
import 'package:fundee/Screen/Patient/suggestion_detail_screen.dart';

class PatientHistoryScreen extends StatefulWidget {
  final FirebaseUser user;
  PatientHistoryScreen(this.user, {Key key}) : super(key: key);
  @override
  _PatientHistoryScreenState createState() => _PatientHistoryScreenState();
}

class _PatientHistoryScreenState extends State<PatientHistoryScreen> {
  @override
  void initState() {
    super.initState();
    getClinic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your History Record'),
        backgroundColor: Colors.blue[300],
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('FunD')
            .document('funD')
            .collection('Clinic')
            .document('clinic')
            .collection(clinic)
            .document(clinic)
            .collection('Patients')
            .document(widget.user.uid)
            .collection('History')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitChasingDots(
                    color: Colors.blue[100],
                    size: 50,
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ],
              ),
            );
          } else if (snapshot.data.documents[0].data.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/Logo/No-data.png',
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    'Oh...',
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        color: Colors.blue[300],
                        fontSize: 25),
                  ),
                  Text(
                    'You don\'t have any history',
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        color: Colors.blue[300],
                        fontSize: 16),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents[0].data['history'].length,
              itemBuilder: (context, index) {
                final idx = index + 1;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '   $idx ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Case: ' +
                                  snapshot.data.documents[0].data['history']
                                      [index]['Detail']),
                              Text('Date: ' +
                                  snapshot.data.documents[0].data['history']
                                      [index]['Date']),
                              Text(
                                'Status: ' +
                                    snapshot.data.documents[0].data['history']
                                        [index]['Status'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text('Responsible by: ' +
                          snapshot.data.documents[0].data['history'][index]
                              ['Dentist']),
                    ),
                    Divider(
                      color: Colors.blueGrey,
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
