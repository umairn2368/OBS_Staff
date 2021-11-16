import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:obs_staff/screens/home/home.dart';
import 'package:obs_staff/screens/login/login.dart';
import 'package:obs_staff/viewmodel/user_list_view_model.dart';
import 'screens/gettingStarted.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => Home(),
          '/login': (BuildContext context) => Login(),
        },

        // home: GettingStarted(),
        home: ChangeNotifierProvider(
            create: (context) => UserListViewModel(), child: GettingStarted()),
      ),
      designSize: const Size(428, 926),
    );
  }
}
