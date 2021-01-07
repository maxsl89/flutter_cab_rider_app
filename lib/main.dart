import 'package:cubrider/screens/mainpage.dart';
import 'package:cubrider/screens/loginpage.dart';
import 'package:cubrider/screens/registrationpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
      appId: '1:297855924061:ios:c6de2b69b03a5be8',
      apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
      projectId: 'flutter-firebase-plugins',
      messagingSenderId: '297855924061',
      databaseURL: 'https://beetaxi-f0f10-default-rtdb.europe-west1.firebasedatabase.app',
    )
        : FirebaseOptions(
      appId: '1:490594976115:android:ec98282689c890a41f4506',
      apiKey: 'AIzaSyA8C-qjocIZB26Bq2YgfZJmY-gBxZyjQVo',
      messagingSenderId: '490594976115',
      projectId: 'beetaxi-f0f10',
      databaseURL: 'https://beetaxi-f0f10-default-rtdb.europe-west1.firebasedatabase.app',
    ),
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Brand-Regular',
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainPage.id,
      routes: {
        RegistrationPage.id: (context) => RegistrationPage(),
        LoginPage.id: (context) => LoginPage(),
        MainPage.id: (context) => MainPage()
      },
    );
  }
}


