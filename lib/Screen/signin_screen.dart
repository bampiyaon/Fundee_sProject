import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fundee/Screen/Dentist/Signup/fb_d_signup_screen.dart';
import 'package:fundee/Screen/Dentist/dentist_menu_screen.dart';
import 'package:fundee/Screen/Patient/patient_menu_screen.dart';
import 'package:fundee/Screen/SignupProcess/gg_select_role.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'SignupProcess/fb_select_role.dart';
import 'constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fundee/Screen/SignupProcess/fb_select_role.dart';

enum LoginType { email, google }

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    checkAuth(context);
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // void _loginUser(
  //     {@required LoginType type,
  //     String email,
  //     String password,
  //     BuildContext context}) async {
  //   CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

  //   try {
  //     String _returnString;

  //     switch (type) {
  //       case LoginType.email:
  //         _returnString =
  //             await _currentUser.loginUserWithEmail(email, password);
  //         break;
  //       case LoginType.google:
  //         _returnString = await _currentUser.loginUserWithGoogle();
  //         break;
  //       default:
  //     }

  //     if (_returnString == 'success') {
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => Home(),
  //           ),
  //           (route) => false);
  //     } else {
  //       Scaffold.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(_returnString),
  //           duration: Duration(seconds: 3),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bBackgroundColor,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 650),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/ToothbrushFixed.jpg"),
                      fit: BoxFit.cover,
                      // alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Flexible(
                  fit: FlexFit.loose,
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "SIGN IN",
                              style: Theme.of(context).textTheme.display1,
                            ),
                            PopupMenuButton(
                              child: Text("SIGN UP",
                                  style: TextStyle(
                                      color: bPrimaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              onSelected: (result) {
                                if (result == 0) {
                                  Navigator.pushNamed(context, 'DSignUp');
                                }
                                if (result == 1) {
                                  Navigator.pushNamed(context, 'PSignUp');
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      // Icon(Icons.local_hospital),
                                      SizedBox(width: 10.0),
                                      Text("Dentist",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                  value: 0,
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      // Icon(Icons.person),
                                      SizedBox(width: 10.0),
                                      Text("Patient",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                  value: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.email,
                                  color: bPrimaryColor,
                                ),
                              ),
                              Flexible(
                                  fit: FlexFit.loose,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Email Address"),
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _emailController,
                                  ))
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.lock,
                                color: bPrimaryColor,
                              ),
                            ),
                            Flexible(
                                fit: FlexFit.loose,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  // controller: ,
                                  decoration:
                                      InputDecoration(hintText: "Password"),
                                  obscureText: true,
                                  controller: _passwordController,
                                ))
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white.withOpacity(.5),
                                        )),
                                    child: Icon(FontAwesomeIcons.facebookF,
                                        color: Colors.white.withOpacity(.5)),
                                  ),
                                  onTap: () => loginWithFacebook(context)),
                              SizedBox(width: 20),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withOpacity(.5),
                                      )),
                                  child: Icon(FontAwesomeIcons.google,
                                      color: Colors.white.withOpacity(.5)),
                                ),
                                onTap: () {
                                  loginWithGoogle(context);
                                },
                              ),
                              Spacer(),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: bPrimaryColor,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  signIn();
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  //Email SignIn
  Future<FirebaseUser> signIn() async {
    await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
    // checkAuth(context);
    email:
    _emailController.text.trim();
    password:
    _passwordController.text.trim();
    checkAuth(context);
  }

  //Google SignIn
  Future loginWithGoogle(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
      'https://www.googleapis.com/auth/cloud-platform.read-only',
    ]);
    GoogleSignInAccount user = await _googleSignIn.signIn();
    GoogleSignInAuthentication userAuth = await user.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: null, accessToken: userAuth.accessToken);
    AuthResult authResult = await _auth.signInWithCredential(credential);
    if (authResult.additionalUserInfo.isNewUser) {
      selectRoleGoogle(context);
    } else {
      checkAuthGoogle(context);
    }
  }

  //Facebook SignIn
  Future loginWithFacebook(BuildContext context) async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult result =
        await facebookLogin.logIn(['email', 'public_profile']);

    if (result.status == FacebookLoginStatus.loggedIn) {
      FacebookAccessToken token = result.accessToken;
      AuthCredential credential =
          FacebookAuthProvider.getCredential(accessToken: token.token);
      print("Access Token = $token");
      AuthResult authResult = await _auth.signInWithCredential(credential);
      if (authResult.additionalUserInfo.isNewUser) {
        selectRoleFacebook(context);
      } else {
        checkRole();
      }
      var user = await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  Future checkAuth(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      print("Already signin with Email");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => DentMenuScreen(user)));
    }
  }

  Future checkAuthFacebook(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      print("Already signin with Social media");
      print(user.toString());
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => DentMenuScreen(user)));
    }
  }

  Future checkAuthGoogle(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      print("Already signin with");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => PatientMenuScreen(user)));
      //ตั้งให้ไปหน้า Patient ก่อน
    }
  }

  Future selectRoleFacebook(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FbSelectRole(user)));
    }
  }

  Future selectRoleGoogle(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => GgSelectRole(user)));
    }
  }

  Future checkRole() {
    StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        // FirebaseAuth.instance.currentUser().then((user) {
        //   if (user.phoneNumber ==
        //       Firestore.instance
        //           .collection('Account')
        //           .document('account')
        //           .collection('Dentists')
        //           .document()
        //           .documentID) {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => DentMenuScreen(user)));
        //   }
        //   if (user.phoneNumber ==
        //       Firestore.instance
        //           .collection('Account')
        //           .document('account')
        //           .collection('Patients')
        //           .document()
        //           .documentID) {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => PatientMenuScreen(user)));
        //   }
        // });

        // if (snapshot.hasData) {
        //   Provider.of(context).curretUserId = snapshot.data.uid;
        //   if (account.collection('').document().parent() == 'Dentists'){

        //   }
        //            {
        //     //
        //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DentMenuScreen(user)));
        //   }
        //   // Provider.of<UserData>(context).currentUserId = snapshot.data.uid;

        // }
      },
    );

    // FirebaseAuth.instance.currentUser().then((user) {
    //   Firestore.instance
    //       .collection('Account')
    //       .document('account')
    //       .collection('Dentists')
    //       .where('uid', isEqualTo: user.uid)
    //       .getDocuments()
    //       .then((docs) {
    //     if (docs.documents[0].exists) {
    //       if (docs.documents[0].data['role'] == 'dentist') {
    //         Navigator.push(
    //             context,
    //             new MaterialPageRoute(
    //                 builder: (BuildContext context) => DentMenuScreen(user)));
    //       } else {
    //         print('Not Authorized');
    //       }
    //     }
    //   });
    // });

    // return StreamBuilder(
    //     stream: FirebaseAuth.instance.onAuthStateChanged,
    //     builder: (BuildContext context, snapshot) {
    //       if(!snapshot.hasData){
    //       }
    //     });
  }
}
