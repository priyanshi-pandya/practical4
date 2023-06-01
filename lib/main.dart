import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_login/homepage.dart';
import 'package:signup_login/view/authentication/login.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(GetMaterialApp(
      home:MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var userExist = false;

  checkuser() async{
    // Obtain shared preferences.
     SharedPreferences prefs = await SharedPreferences.getInstance();
  //  get data from backgrond and see if uid is stored in background.  if it is then directly navigate to Dashboard page

    if(prefs.getString('uid') != null){
      setState(() {
        userExist = true;
      });
      print('uid is : ${prefs.getString('uid')}');
    }
  }

  @override
  void initState() {
    super.initState();
    //check if user has already registered
    checkuser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userExist
          ? const Dashboard(): const LoginPage()
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const GetMaterialApp(
//       title: "My Quotes",
//        home: LoginPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
