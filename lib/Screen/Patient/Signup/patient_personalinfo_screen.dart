import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundee/Screen/signin_screen.dart';
import 'package:fundee/Services/add_patient_service.dart';
import 'package:intl/intl.dart';
import 'package:fundee/Screen/Patient/Signup/patient_signup_screen.dart';

import '../../../font_awesome_flutter.dart';
import '../../constants.dart';

class PatientPersonalInfoScreen extends StatefulWidget {
  @override
  _PatientPersonalInfoScreenState createState() =>
      _PatientPersonalInfoScreenState();
}

class _PatientPersonalInfoScreenState extends State<PatientPersonalInfoScreen> {
  DateTime _currentDate = new DateTime.now();
  final formatDate = new DateFormat('dd-MM-yyyy');
  final drugallergy = TextEditingController();
  final tel = TextEditingController();
  final birthdate = TextEditingController();

  Future<Null> _selectdate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
        context: context,
        initialDate: _currentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        });
    if (_seldate != null) {
      setState(() {
        _currentDate = _seldate;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    String _formattedate = new DateFormat.yMMMd().format(_currentDate);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/patient-signup-screen.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Positioned(
              child: Stack(
                children: <Widget>[
                  Positioned(
                      bottom: -10,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Welcome to Fun-D',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ))
                ],
              ),
            ),
          ),
          Positioned(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Personal Information',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    FontAwesomeIcons.birthdayCake,
                    color: bPrimaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: FlatButton(
                      textColor: Colors.black54,
                      child: Text('$_formattedate',
                          style: new TextStyle(
                              fontSize: 17, fontWeight: FontWeight.normal)),
                      onPressed: () {
                        _selectdate(context);
                      }),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.phone,
                    color: bPrimaryColor,
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(right: 20, left: 10),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Phone Number"),
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    controller: tel,
                  ),
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    FontAwesomeIcons.pills,
                    color: bPrimaryColor,
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(right: 20, left: 10),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Drug Allergy"),
                    controller: drugallergy,
                  ),
                )),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              FittedBox(
                child: GestureDetector(
                  onTap: () {
                    // addPatient(context, {'fisrtName': fname.text}, documentName);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SignInScreen();
                      },
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: bPrimaryColor,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "SIGN UP",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     String _formattedate = new DateFormat.yMMMd().format(_currentDate);
//     return Scaffold(
//       body: ListView(
//         children: <Widget>[
//           Container(
//             height: 200,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/images/ToothbrushFixed.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Positioned(
//               child: Stack(
//                 children: <Widget>[
//                   Positioned(
//                       bottom: -10,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Text(
//                           'Welcome to Fun-D',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20),
//                         ),
//                       ))
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//               child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Text(
//               'Personal Information',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.normal,
//                   fontSize: 16),
//             ),
//           )),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(right: 16),
//                   child: Icon(
//                     FontAwesomeIcons.birthdayCake,
//                     color: bPrimaryColor,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 0),
//                   child: FlatButton(
//                       textColor: Colors.black54,
//                       child: Text('$_formattedate',
//                           style: new TextStyle(
//                               fontSize: 17, fontWeight: FontWeight.normal)),
//                       onPressed: () {
//                         _selectdate(context);
//                       }),
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(right: 16),
//                   child: Icon(
//                     Icons.phone,
//                     color: bPrimaryColor,
//                   ),
//                 ),
//                 Expanded(
//                     child: Container(
//                   margin: EdgeInsets.only(right: 20, left: 10),
//                   child: TextFormField(
//                     decoration: InputDecoration(hintText: "Phone Number"),
//                     keyboardType: TextInputType.phone,
//                     inputFormatters: <TextInputFormatter>[
//                       WhitelistingTextInputFormatter.digitsOnly,
//                     ],
//                     controller: tel,
//                   ),
//                 )),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(right: 16),
//                   child: Icon(
//                     FontAwesomeIcons.pills,
//                     color: bPrimaryColor,
//                   ),
//                 ),
//                 Expanded(
//                     child: Container(
//                   margin: EdgeInsets.only(right: 20, left: 10),
//                   child: TextFormField(
//                     decoration: InputDecoration(hintText: "Drug Allergy"),
//                     controller: drugallergy,
//                   ),
//                 )),
//               ],
//             ),
//           ),
//           Column(
//             children: <Widget>[
//               FittedBox(
//                 child: GestureDetector(
//                   onTap: () {
//                     Firestore.instance.collection('patients').add(
//                       {
//                         // 'firstname' : fname.text,

//                       }
//                     );
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return SignInScreen();
//                       },
//                     ));
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(bottom: 20),
//                     padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(25),
//                       color: bPrimaryColor,
//                     ),
//                     child: Row(
//                       children: <Widget>[
//                         Text(
//                           "SIGN UP",
//                           style: Theme.of(context)
//                               .textTheme
//                               .button
//                               .copyWith(color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }