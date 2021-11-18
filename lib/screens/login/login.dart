// ignore_for_file: unused_import, use_key_in_widget_constructors, unused_field, prefer_const_constructors, non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obs_staff/screens/home/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _fromKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  var obsucreText = true;

  var validate = false;
  bool isLoading = true;

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Please enter email and password"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogEmptyEmail(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Please enter email"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogEmptyPassword(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Please enter password"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogInvalidUser(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Invalid User"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Image(
        image: AssetImage(
          'assets/images/login-bottom.png',
        ),
      ),
      body:
          // SafeArea(
          //   child:
          SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 194.h),
              Center(
                child: Image(
                  image: const AssetImage(
                    'assets/images/obs-logo.png',
                  ),
                  height: 106.sp,
                  width: 188.sp,
                ),
              ),
              SizedBox(height: 113.h),
              Container(
                margin: EdgeInsets.only(top: 0.0, left: 30.w, right: 30.w),
                padding: EdgeInsets.only(top: 0.0, left: 20.w, right: 20.w),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50)),
                child: TextField(
                  controller: _email,
                  style: const TextStyle(color: Colors.yellow),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Employee ID',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(255, 212, 0, 0.32),
                      fontSize: 16.0,
                    ),
                    icon: Icon(
                      Icons.person,
                      color: Color.fromRGBO(219, 165, 20, 1),
                      size: 20.0,
                    ),
                  ),
                  obscureText: false,
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                margin: EdgeInsets.only(top: 0.0, left: 30.w, right: 30.w),
                padding: EdgeInsets.only(top: 0.0, left: 20.w, right: 0.w),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50)),
                child: TextField(
                  controller: _password,
                  style: TextStyle(color: Colors.yellow),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(255, 212, 0, 0.32),
                      fontSize: 16.0,
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: Color.fromRGBO(219, 165, 20, 1),
                      size: 20.0,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obsucreText = !obsucreText;
                          validate = true;
                        });
                      },
                      child: obsucreText
                          ? Icon(
                              Icons.visibility_off,
                              color: Color.fromRGBO(219, 165, 20, 1),
                              size: 20.0,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Color.fromRGBO(219, 165, 20, 1),
                              size: 20.0,
                            ),
                    ),
                  ),
                  obscureText: obsucreText,
                ),
              ),
              SizedBox(height: 11.h),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1, // 60% of space => (6/(6 + 4))
                    child: Align(
                      alignment: Alignment(0.75, -80.0),
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Center(
                child: Container(
                  height: 47.h,
                  width: 155.w,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.yellowAccent,
                    color: Color.fromRGBO(255, 212, 0, 1),
                    elevation: 5.0,
                    child: GestureDetector(
                      onTap: isLoading != true
                          ? null
                          : () {
                              var email = _email.text;
                              var password = _password.text;
                              setState(() {
                                isLoading = false;
                              });
                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                SignIn(email, password);
                              });
                            },
                      child: Center(
                        child: isLoading
                            ? Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            : SpinKitCircle(color: Colors.black, size: 30)
                        //CircularProgressIndicator(color: Colors.black)
                        ,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  void SignIn(String email, String password) async {
    if (email.isEmpty && password.isEmpty) {
      setState(() {
        isLoading = true;
      });
      showAlertDialog(context);
    } else if (email.isEmpty) {
      setState(() {
        isLoading = true;
      });
      showAlertDialogEmptyEmail(context);
    } else if (password.isEmpty) {
      setState(() {
        isLoading = true;
      });
      showAlertDialogEmptyPassword(context);
    } else {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uuid) => {
                setState(() {
                  isLoading = true;
                }),
                Fluttertoast.showToast(msg: "Login Successfully"),
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Home();
                    },
                  ),
                  (route) => false,
                )
              })
          .catchError((e) {
        setState(() {
          isLoading = true;
        });
        Fluttertoast.showToast(msg: e!.message);
        if (e!.message ==
            'There is no user record corresponding to this identifier. The user may have been deleted.') {
          showAlertDialogInvalidUser(context);
        }
      });
    }
  }
}
