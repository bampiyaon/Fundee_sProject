import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fundee/States/current_user.dart';
import 'package:provider/provider.dart';
import '../home.dart';
import 'constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum LoginType { email, google }

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final fbLogin = FacebookLogin();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _loginUser(
      {@required LoginType type,
      String email,
      String password,
      BuildContext context}) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      String _returnString;

      switch (type) {
        case LoginType.email:
          _returnString =
              await _currentUser.loginUserWithEmail(email, password);
          break;
        case LoginType.google:
          _returnString = await _currentUser.loginUserWithGoogle();
          break;
        default:
      }

      if (_returnString == 'success') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
            (route) => false);
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnString),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
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
          Expanded(
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
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.pushNamed(context, 'SignUp');
                        //   },
                        //   child: Text(
                        //     "SIGN UP",
                        //     style: Theme.of(context).textTheme.button,
                        //   ),
                        // ),
                        FlatButton(
                          textColor: bPrimaryColor,
                          child: Text('SIGN UP'),
                          onPressed: () {
                            Navigator.pushNamed(context, 'PSignUp');
                          },
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
                          Expanded(
                              child: TextField(
                            decoration:
                                InputDecoration(hintText: "Email Address"),
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
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.text,
                          // controller: ,
                          decoration: InputDecoration(hintText: "Password"),
                          obscureText: true,
                          controller: _passwordController,
                        ))
                      ],
                    ),
                    // Spacer(),
                    // Center(
                    //   child: RichText(
                    //       text: TextSpan(
                    //     text: 'Don\'t have an account?',
                    //     style: TextStyle(color: Colors.black38),
                    //   )),
                    // ),
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
                              _loginUser(
                                  type: LoginType.google, context: context);
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
                              _loginUser(
                                  type: LoginType.email,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  context: context);
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
    );
  }

  Future loginWithFacebook(BuildContext context) async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult result =
        await facebookLogin.logIn(['email', 'public_profile']);

    if (result.status == FacebookLoginStatus.loggedIn) {
      FacebookAccessToken facebookAccessToken = result.accessToken;
      AuthCredential authCredential = FacebookAuthProvider.getCredential(
          accessToken: facebookAccessToken.token);
      FirebaseUser fbUser;
      fbUser =
          (await FirebaseAuth.instance.signInWithCredential(authCredential))
              .user;
    }
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
  }
}
