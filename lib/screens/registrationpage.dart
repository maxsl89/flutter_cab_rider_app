import 'package:cubrider/brand_colors.dart';
import 'package:cubrider/screens/loginpage.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {

  static const String id = 'register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                        RaisedButton(
                          onPressed: (){

                          },
                          color: BrandColors.colorGreen,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(25)
                          ),
                          textColor: Colors.white,
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                  'РЕГИСТРАЦИЯ',
                                  style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold')
                              ),
                            ),
                          ),
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
