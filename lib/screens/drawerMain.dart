// ignore_for_file: file_names, unused_import, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:obs_staff/screens/home/home.dart';
import 'package:obs_staff/screens/profile.dart';
import 'package:obs_staff/screens/search.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:obs_staff/models/user_model.dart';
import 'package:flutter/widgets.dart';

class DrawerMain extends StatefulWidget {
  @override
  _DrawerMainState createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  var employeeName = '';
  var employeeDesignation = '';
  var employeeStatus = '';
  var employeeAvatar = '';

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) => {
              loggedInUser = UserModel.fromMap(value.data()),
              setState(() {
                employeeName = loggedInUser.name!;
                employeeDesignation = loggedInUser.role!;
                employeeStatus = loggedInUser.status!;
                employeeAvatar = loggedInUser.avatar!;
              }),
            });
  }

  showAlertDialogInvalidUser() {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pushNamed('/login');
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you want to logout?"),
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
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 1)),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Color.fromRGBO(0, 0, 0, 1),
              child: Center(
                child: Column(
                  children: <Widget>[
                    employeeAvatar != ''
                        ? Row(
                            children: [
                              Container(
                                width: 54.w,
                                height: 54.h,
                                margin: EdgeInsets.only(top: 30),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${this.employeeAvatar}"),
                                        fit: BoxFit.fill)),
                              ),
                              SizedBox(width: 19.w),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(
                                  "${this.employeeName.toUpperCase()}",
                                  style: TextStyle(
                                    fontSize: 18.0.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(255, 212, 0, 1),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Container(
                                width: 54.w,
                                height: 54.h,
                                margin: EdgeInsets.only(top: 30),
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/avatar.png',
                                  ),
                                  width: 54.w,
                                  height: 54.h,
                                ),
                              ),
                              SizedBox(width: 19.w),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(
                                  "${employeeName.toUpperCase()}",
                                  style: TextStyle(
                                    fontSize: 18.0.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(255, 212, 0, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1.0, color: Color.fromRGBO(255, 212, 0, 1)),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 44.h),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Color.fromRGBO(255, 212, 0, 1),
              ),
              title: Text(
                'Dashboard',
                style: TextStyle(color: Color.fromRGBO(255, 212, 0, 1)),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/home');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Color.fromRGBO(255, 212, 0, 1),
              ),
              title: Text(
                'Leave Request',
                style: TextStyle(color: Color.fromRGBO(255, 212, 0, 1)),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/profile');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Color.fromRGBO(255, 212, 0, 1),
              ),
              title: Text(
                'Employee of the month',
                style: TextStyle(color: Color.fromRGBO(255, 212, 0, 1)),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/search');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Color.fromRGBO(255, 212, 0, 1),
              ),
              title: Text(
                'Log out',
                style: TextStyle(color: Color.fromRGBO(255, 212, 0, 1)),
              ),
              onTap: () {
                // Navigator.of(context).pushNamed('/login');
                showAlertDialogInvalidUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}
