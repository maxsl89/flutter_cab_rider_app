import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:cubrider/brand_colors.dart';
import 'package:cubrider/screens/mainpage.dart';
import 'package:cubrider/screens/registrationpage.dart';
import 'package:cubrider/widgets/ProgressDialog.dart';
import 'package:cubrider/widgets/TaxiButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
 
class LoginPage extends StatefulWidget {

  static const String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar = SnackBar(
        content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),)
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void login () async {

    // show please wait dialog
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDialog(status: 'Подождите',)
    );

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );

      if(userCredential != null){
        // verify login
        DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users/${userCredential.user.uid}');

        userRef.once().then((DataSnapshot snapshot) => {
          if(snapshot.value != null){
            Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false)
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        showSnackBar('Пользователь с таким имейлом не найден');
      } else if (e.code == 'wrong-password') {
        showSnackBar('Не верный пароль');
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 70,),
                Image(
                  alignment: Alignment.center,
                  height: 100.0,
                  width: 100.0,
                  image: AssetImage('images/logo.png'),
                ),
                SizedBox(height: 40),
                Text('Войти как водитель',
                textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold')
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Email адрес",
                            labelStyle: TextStyle(
                                fontSize: 14
                            ),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.0
                            )
                        ),
                        style: TextStyle(fontSize: 14),
                      ),

                      SizedBox(height: 10),

                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Пароль",
                            labelStyle: TextStyle(
                                fontSize: 14
                            ),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.0
                            )
                        ),
                        style: TextStyle(fontSize: 14),
                      ),

                      SizedBox( height: 40),

                      TaxiButton(
                        title: 'ВОЙТИ',
                        color: BrandColors.colorGreen,
                        onPressed: () async {
                          //check network availability
                          var connectivityResult = await Connectivity().checkConnectivity();
                          if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
                            showSnackBar('Нет интернет соединения');
                            return;
                          }

                          if(!emailController.text.contains('@')){
                            showSnackBar('Введите корректный имейл');
                            return;
                          }

                          if(passwordController.text.length < 8){
                            showSnackBar('Пароль должен состоять минимум из 8 символов');
                            return;
                          }

                          login();

                        },
                      ),


                    ],
                  ),
                ),

                FlatButton(
                    onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(context, RegistrationPage.id, (route) => false);
                    },
                    child: Text('Не зарегистрированы? Создайте аккаунт'))


              ],
            ),
          ),
        ),
      )
    );
  }
}


