// ignore_for_file: file_names, prefer_const_constructors, unused_import, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:obs_staff/screens/utilities/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GettingStarted extends StatefulWidget {
  @override
  _GettingStarted createState() => _GettingStarted();
}

class _GettingStarted extends State<GettingStarted> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 10,
      width: isActive ? 10.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive
            ? Color.fromRGBO(0, 0, 0, 1)
            : Color.fromRGBO(255, 212, 0, 1),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => Navigator.of(context).pushNamed('/login'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Skip',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            fontSize: 22.0,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          size: 25.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 650.0.h,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/attendence-main.png',
                                ),
                                height: 304.sp,
                                width: 417.sp,
                              ),
                            ),
                            SizedBox(height: 45.h),
                            Center(
                              child: Text(
                                "Track Employee's",
                                style: TextStyle(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                            ),
                            SizedBox(height: 9.h),
                            Center(
                              child: TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(20.w, 6.w, 20.w, 6.w),
                                  child: Text(
                                    'ATTENDENCE',
                                    style: TextStyle(
                                      fontSize: 26.sp,
                                      color: Color.fromRGBO(255, 212, 0, 1),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 36.h),
                            Center(
                              child: Text(
                                "Get updates of employee's",
                                style: TextStyle(
                                  fontSize: 21.sp,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Center(
                              child: Text(
                                "daily attendance",
                                style: TextStyle(
                                  fontSize: 21.sp,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                          // ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/workinghours-main.png',
                                ),
                                 height: 304.sp,
                                width: 417.sp,
                              ),
                            ),
                            SizedBox(height: 45.h),
                            Center(
                              child: Text(
                                "Calculate Working",
                                style: TextStyle(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                            ),
                            SizedBox(height: 9.h),
                            Center(
                              child: TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(20.w, 6.w, 20.w, 6.w),
                                  child: Text(
                                    'HOURS',
                                    style: TextStyle(
                                      fontSize: 26.sp,
                                      color: Color.fromRGBO(255, 212, 0, 1),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 36.h),
                            Center(
                              child: Text(
                                "Get updates of employee's",
                                style: TextStyle(
                                  fontSize: 21.sp,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Center(
                              child: Text(
                                "daily attendance",
                                style: TextStyle(
                                  fontSize: 21.sp,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                          // ),
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/calendar-main.png',
                                ),
                                   height: 304.sp,
                                width: 417.sp,
                              ),
                            ),
                            SizedBox(height: 45.h),
                            Center(
                              child: Text(
                                "Manage Employee's",
                                style: TextStyle(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                            ),
                            SizedBox(height: 9.h),
                            Center(
                              child: TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(20.w, 6.w, 20.w, 6.w),
                                  child: Text(
                                    'LEAVES',
                                    style: TextStyle(
                                      fontSize: 26.sp,
                                      color: Color.fromRGBO(255, 212, 0, 1),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 36.h),
                            Center(
                              child: Text(
                                "Get updates of employee's",
                                style: TextStyle(
                                  fontSize: 21.sp,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Center(
                              child: Text(
                                "daily attendance",
                                style: TextStyle(
                                  fontSize: 21.sp,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
               SizedBox(height: 60.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
