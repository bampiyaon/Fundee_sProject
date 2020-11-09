import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fundee/Screen/Dentist/dentist_menu_screen.dart';
import 'package:fundee/font_awesome_flutter.dart';

import 'DentRecord/dentalRecord.dart';

class PatientList extends StatefulWidget {
  final FirebaseUser user;
  PatientList(this.user, {Key key}) : super(key: key);
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _patient = [];
  bool _loadingPatient = true;

  _getPatient() async {
    Query q = _firestore
        .collection('FunD')
        .document('funD')
        .collection('Clinic')
        .document('clinic')
        .collection(clinic)
        .document(clinic)
        .collection('Patients')
        .orderBy('fullName');

    setState(() {
      _loadingPatient = true;
    });

    QuerySnapshot querySnapshot = await q.getDocuments();
    _patient = querySnapshot.documents;

    setState(() {
      _loadingPatient = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPatient();
    getClinic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
        backgroundColor: Colors.blue[300],
        automaticallyImplyLeading: false,
      ),
      body: _loadingPatient == true
          ? Container(
              child: Center(
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
            ))
          : Container(
              child: _patient.length == 0
                  ? Center(
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
                            'You don\'t have any patient',
                            style: TextStyle(
                                fontFamily: 'Kanit',
                                color: Colors.blue[300],
                                fontSize: 16),
                          ),
                          // )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _patient.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DentalRecord(
                                          uid: _patient[index].data['uid'],
                                          fullname:
                                              _patient[index].data['fullName'],
                                        )));
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                                child: ClipOval(
                              child: Image.network(
                                  _patient[index].data['pathImage']),
                            )),
                            trailing: Icon(FontAwesomeIcons.angleRight),
                            title: Text(_patient[index].data['fullName']),
                            subtitle: Text(_patient[index].data['tel']),
                          ),
                        );
                      }),
            ),
    );
  }
}
