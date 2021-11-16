// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, use_key_in_widget_constructors, prefer_final_fields, unused_field, unnecessary_brace_in_string_interps, unnecessary_string_interpolations
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:obs_staff/models/attendence_model.dart';
import 'package:obs_staff/models/user_model.dart';
import 'package:obs_staff/screens/dashboard.dart';
import 'package:obs_staff/screens/drawerMain.dart';
import 'package:obs_staff/screens/home/styles..dart';
import 'package:obs_staff/screens/login/login.dart';
import 'package:obs_staff/screens/profile.dart';
import 'package:obs_staff/screens/search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  AttendenceModel attendenceUser = AttendenceModel();

  bool isCheckOut = false;

  bool isLoading = true;
  var employeeName = '';
  var employeeDesignation = '';
  var employeeStatus = '';
  var employeeAvatar = '';
  var employeeId = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() {
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
                employeeId = loggedInUser.uid!;
                isLoading = false;
              }),
            });

    DateTime now = DateTime.now();

    var time = (now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString());

    var date = (now.day.toString() +
        ":" +
        now.month.toString() +
        ":" +
        now.year.toString());

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('attendence');

    collectionReference
        .where("userId", isEqualTo: user!.uid)
        .where("date", isEqualTo: date)
        .get()
        .then((querySnapshot) {
      var result = querySnapshot.docs.first;
      var todayAttendence = AttendenceModel.fromMap(result.data());
      if (todayAttendence.checkInTime != "" &&
          todayAttendence.checkOutTime != "") {
        this.setState(() {
          isCheckOut = true;
        });
        print(isCheckOut);
      } else {
        this.setState(() {
          isCheckOut = false;
        });
        print(isCheckOut);
      }
    });
  }

  checkIn() {
    FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
      "status": "CheckIn",
    }, SetOptions(merge: true)).then((_) {
      print("CheckIn Success!");
    });

    DateTime now = DateTime.now();

    var time = (now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString());

    var date = (now.day.toString() +
        ":" +
        now.month.toString() +
        ":" +
        now.year.toString());

    Map<String, dynamic> data = {
      "checkInTime": time,
      "date": date,
      "checkOutTime": "",
      "userId": employeeId,
    };

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('attendence');
    collectionReference.add(data);
    getUserData();
  }

  checkOut() {
    FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
      "status": "CheckOut",
    }, SetOptions(merge: true)).then((_) {
      print("success!");
    });

    DateTime now = DateTime.now();

    var time = (now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString());

    var date = (now.day.toString() +
        ":" +
        now.month.toString() +
        ":" +
        now.year.toString());

    var resultFinal;

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('attendence');

    collectionReference
        .where("userId", isEqualTo: user!.uid)
        .where("date", isEqualTo: date)
        .get()
        .then((querySnapshot) {
      var result = querySnapshot.docs.first;
      print(querySnapshot.docs.first.id);
      FirebaseFirestore.instance
          .collection("attendence")
          .doc(querySnapshot.docs.first.id)
          .set({
        "checkOutTime": time,
      }, SetOptions(merge: true)).then((_) {
        print("checkOutTime Success!");
      });
    });
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 212, 0, 1),
          foregroundColor: Color.fromRGBO(0, 0, 0, 1),
          leading: IconButton(
            icon: Icon(Icons.dehaze),
            onPressed: () {
              if (_scaffoldKey.currentState!.isDrawerOpen == false) {
                _scaffoldKey.currentState!.openDrawer();
              } else {
                _scaffoldKey.currentState!.openEndDrawer();
              }
            },
          ),
        ),
        //drawer: DrawerMain(),
        body: Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            drawer: DrawerMain(),
            drawerScrimColor: Color.fromRGBO(255, 212, 0, 0.27),
            body: SingleChildScrollView(
              child: isLoading
                  ? Column(children: [
                      SizedBox(height: 50.h),
                      Center(
                          child: 
                          // CircularProgressIndicator(
                          //     color: Color.fromRGBO(0, 0, 0, 1))
                          
                          SpinKitCircle(color: Color.fromRGBO(255, 212, 0, 1), size:30))
                    ])
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                          SizedBox(height: 40.h),
                          Container(
                            height: 171.h,
                            width: 410.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: Color.fromRGBO(255, 212, 0, 1),
                            ),
                            child: employeeAvatar != ''
                                ? Row(children: <Widget>[
                                    SizedBox(width: 42.w),
                                    Container(
                                      width: 94.w,
                                      height: 94.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${this.employeeAvatar}"),
                                              fit: BoxFit.fill)),
                                    ),
                                    SizedBox(width: 19.w),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 46.h),
                                        Text("${this.employeeName}",
                                            style: titleBoldStyle),
                                        SizedBox(height: 5.h),
                                        Text(
                                          "${this.employeeDesignation}",
                                          style: titleStyle,
                                        ),
                                        SizedBox(height: 5.h),
                                        Text("${this.employeeStatus}",
                                            style: titleStyle),
                                      ],
                                    ),
                                  ])
                                : Row(children: <Widget>[
                                    SizedBox(width: 42.w),
                                    Container(
                                      width: 94.w,
                                      height: 94.h,
                                      child: Image(
                                        image: AssetImage(
                                          'assets/images/avatar.png',
                                        ),
                                        width: 54.w,
                                        height: 54.h,
                                      ),
                                    ),
                                    SizedBox(width: 19.w),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 46.h),
                                        Text(
                                          //'Umair Naseer',
                                          "${this.employeeName}",
                                          style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                              fontFamily: 'Montserrat-Bold'),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          //'React Native Developer',
                                          "${this.employeeDesignation}",
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.25),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                              fontFamily: 'Montserrat-Bold'),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          //'Online',
                                          "${this.employeeStatus}",
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.25),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                              fontFamily: 'Montserrat-Bold'),
                                        ),
                                      ],
                                    ),
                                  ]),
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            margin: EdgeInsets.only(
                                top: 0.0, left: 47.w, right: 0.w),
                            child: Text(
                              'Working History',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(255, 212, 0, 1),
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            height: 171.h,
                            width: 381.w,
                            margin: EdgeInsets.only(
                                top: 0.0, left: 47.w, right: 0.w),
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                //color: Color.fromRGBO(255, 212, 0, 1),
                                border: Border.all(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  width: 1,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 65.h),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Total Hours',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                        ),
                                      ),
                                      Text(
                                        '14',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Container(
                                  height: 80,
                                  child: VerticalDivider(
                                      width: 2,
                                      color: Color.fromRGBO(0, 0, 0, 0.25)),
                                ),
                                SizedBox(width: 5.w),
                                Container(
                                  padding: EdgeInsets.only(top: 65.h),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Worked Hours',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                        ),
                                      ),
                                      Text(
                                        '14',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Container(
                                  height: 80,
                                  child: VerticalDivider(
                                      width: 2,
                                      color: Color.fromRGBO(0, 0, 0, 0.25)),
                                ),
                                SizedBox(width: 5.w),
                                Container(
                                  padding: EdgeInsets.only(top: 65.h),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Overtime',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                        ),
                                      ),
                                      Text(
                                        '14',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5.w),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 70.h,
                                width: 155.w,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: isCheckOut != true &&
                                          employeeStatus == 'CheckOut'
                                      ? Colors.yellowAccent
                                      : Color.fromRGBO(0, 0, 0, 0.1),
                                  color: isCheckOut != true &&
                                          employeeStatus == 'CheckOut'
                                      ? Color.fromRGBO(255, 212, 0, 1)
                                      : Color.fromRGBO(0, 0, 0, 0.1),
                                  elevation: 5.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      isCheckOut != true &&
                                              employeeStatus == 'CheckOut'
                                          ? checkIn()
                                          : null;
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: isCheckOut != true &&
                                                    employeeStatus == 'CheckOut'
                                                ? AssetImage(
                                                    'assets/images/check-in-active.png',
                                                  )
                                                : AssetImage(
                                                    'assets/images/check-in-inactive.png',
                                                  ),
                                            height: 32.sp,
                                            width: 21.sp,
                                          ),
                                          Text(
                                            isCheckOut != true &&
                                                    employeeStatus == 'CheckOut'
                                                ? 'Check in'
                                                : 'Check in',
                                            style: TextStyle(
                                                color: isCheckOut != true &&
                                                        employeeStatus ==
                                                            'CheckOut'
                                                    ? Colors.black
                                                    : Color.fromRGBO(
                                                        0, 0, 0, 0.19),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 22.w),
                              Container(
                                height: 70.h,
                                width: 155.w,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: employeeStatus == 'CheckIn' &&
                                          isCheckOut != true
                                      ? Colors.yellowAccent
                                      : Color.fromRGBO(0, 0, 0, 0.1),
                                  color: employeeStatus == 'CheckIn' &&
                                          isCheckOut != true
                                      ? Color.fromRGBO(255, 212, 0, 1)
                                      : Color.fromRGBO(0, 0, 0, 0.1),
                                  elevation: 5.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      employeeStatus == 'CheckIn' &&
                                              isCheckOut != true
                                          ? checkOut()
                                          : null;
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                            image:
                                                employeeStatus == 'CheckIn' &&
                                                        isCheckOut != true
                                                    ? AssetImage(
                                                        'assets/images/check-out-active.png',
                                                      )
                                                    : AssetImage(
                                                        'assets/images/check-out-inactive.png',
                                                      ),
                                            height: 32.sp,
                                            width: 21.sp,
                                          ),
                                          Text(
                                            employeeStatus == 'CheckIn' &&
                                                    isCheckOut != true
                                                ? 'Check out'
                                                : 'Check out',
                                            style: TextStyle(
                                                color: employeeStatus ==
                                                            'CheckIn' &&
                                                        isCheckOut != true
                                                    ? Colors.black
                                                    : Color.fromRGBO(
                                                        0, 0, 0, 0.19),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 20.0, left: 47.w, right: 0.w),
                            child: Text(
                              'Birthdays',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(255, 212, 0, 1),
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            height: 94.h,
                            width: 382.w,
                            margin: EdgeInsets.only(
                                top: 0.0, left: 25.w, right: 25.w),
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                border: Border.all(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  width: 1,
                                )),
                            child: employeeAvatar != ''
                                ? Row(children: <Widget>[
                                    Container(
                                      width: 62.w,
                                      height: 62.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${employeeAvatar}"),
                                              fit: BoxFit.fill)),
                                    ),
                                    SizedBox(width: 24.w),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 16.h),
                                        Text("${employeeName}",
                                            style: titleBoldStyle),
                                        SizedBox(height: 5.h),
                                        Text(
                                          "${employeeDesignation}",
                                          style: titleStyle,
                                        ),
                                        //SizedBox(height: 5.h),
                                        Text("${employeeStatus}",
                                            style: titleStyle),
                                      ],
                                    ),
                                    SizedBox(width: 70.w),
                                    Container(
                                      child: Image(
                                        image: AssetImage(
                                          'assets/images/arrow-down.png',
                                        ),
                                        height: 32.sp,
                                        width: 21.sp,
                                      ),
                                    )
                                  ])
                                : Row(children: <Widget>[
                                    Container(
                                      width: 62.w,
                                      height: 62.h,
                                      child: Image(
                                        image: AssetImage(
                                          'assets/images/avatar2.png',
                                        ),
                                        width: 54.w,
                                        height: 54.h,
                                      ),
                                    ),
                                    SizedBox(width: 24.w),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 16.h),
                                        Text("${employeeName}",
                                            style: titleBoldStyle),
                                        SizedBox(height: 5.h),
                                        Text(
                                          "${employeeDesignation}",
                                          style: titleStyle,
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          "${employeeStatus}",
                                          style: titleStyle,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 70.w),
                                    Container(
                                      child: Image(
                                        image: AssetImage(
                                          'assets/images/arrow-down.png',
                                        ),
                                        height: 32.sp,
                                        width: 21.sp,
                                      ),
                                    )
                                  ]),
                          ),
                        ]),
            )));
  }
}

Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) {
        return Login();
      },
    ),
    (route) => false,
  );
}
