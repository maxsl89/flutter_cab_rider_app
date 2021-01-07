import 'package:connectivity/connectivity.dart';
import 'package:cubrider/brand_colors.dart';
import 'package:cubrider/screens/loginpage.dart';
import 'package:cubrider/screens/mainpage.dart';
import 'package:cubrider/widgets/ProgressDialog.dart';
import 'package:cubrider/widgets/TaxiButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {

  static const String id = 'register';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),)
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var fullNameController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  Future<void> registerUser() async {

    // show please wait dialog
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDialog(status: 'Подождите',)
    );

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );

      // check if user registration is successful
      if(userCredential != null){
        DatabaseReference newUserRef = FirebaseDatabase.instance.reference().child('users/${userCredential.user.uid}');

        //prepare data to be saved on users table
        Map userMap = {
          'fullname': fullNameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
        };

        newUserRef.set(userMap);

        //Take the user to the main page
        Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        showSnackBar('Пароль слишком слабый');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        showSnackBar('Пользователь с таким имейлом уже зарегистрирован');
      } else {
        showSnackBar(e.code);
      }
    } catch (e) {
      print(e);
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
                  Text('Регистрация водителя',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold')
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        // Full name
                        TextField(
                          controller: fullNameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "Имя Фамилия",
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
                        // Email address
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

                        // Phone number
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: "Телефон",
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

                        // Password
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
                          title: 'Рагистрация',
                          color: BrandColors.colorGreen,
                          onPressed: () async{

                            //check network availability
                            var connectivityResult = await Connectivity().checkConnectivity();
                            if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
                              showSnackBar('Нет интернет соединения');
                              return;
                            }

                            if(fullNameController.text.length < 3){
                              showSnackBar('Пожалуйста введите полное Имя и Фамилию');
                              return;
                            }

                            if(phoneController.text.length < 10){
                              showSnackBar('Пожалуйста введите корректный номер телефона');
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

                            registerUser();
                          },
                        ),


                      ],
                    ),
                  ),

                  FlatButton(
                      onPressed: (){
                        Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                      },
                      child: Text('Уже есть аккаунт водителя? Войдите'))


                ],
              ),
            ),
          ),
        )
    );
  }
}
