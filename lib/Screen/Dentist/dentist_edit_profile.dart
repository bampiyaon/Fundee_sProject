import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DentEditProfile extends StatefulWidget {
  final FirebaseUser user;
  DentEditProfile(this.user, {Key key}) : super(key: key);
  @override
  _DentEditProfileState createState() => _DentEditProfileState();
}

class _DentEditProfileState extends State<DentEditProfile> {
  File _image;
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: Stack(
              children: <Widget>[
                Container(),
                ClipPath(
                  clipper: MyCustomClipper(),
                  child: Container(
                    height: 260,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [
                          Colors.lightBlue[400],
                          Colors.blue,
                          Colors.indigo[300]
                        ])),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: new SizedBox(
                            width: 120.0,
                            height: 120.0,
                            child: (_image != null)
                                ? Image.file(
                                    _image,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    'assets/images/Logo/App-Icon-drop-shadow.jpg',
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(widget.user.displayName,
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold)),
                      Text(
                        'admin@fund.com',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(210, 210, 0, 0),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.amber[400],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LineAwesomeIcons.pen,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          uploadPic(context);
                        },
                        icon: Icon(
                          Icons.check,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 100);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
