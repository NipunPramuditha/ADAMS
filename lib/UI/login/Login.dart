import 'dart:async';

import 'package:adams/Login/LoginserviceImpl.dart';
import 'package:adams/UI/bot/bot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _text = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 3,
                    child: Column(children: <Widget>[
                      Image.asset('assets/images/robo.png',
                          width: 250.0, height: 320.0),
                      const SizedBox(height: 10.00),
                      Text(_text)
                    ])),
                Expanded(
                  flex: 1,
                  child: Column(children: <Widget>[
                    SignInButton(
                      Buttons.Google,
                      text: "ගූගල් ලියාපදිංචිය",
                      onPressed: () async {
                        print('sign in pressed');
                        bool res = await LoginServiceImpl().signInWithGoogle();
                        print(
                            'google sing in resposnse aaaaaaaaaaaaaaaaa - $res');
                        if (Map == null)
                          print("error logging in with google");
                        else {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => bot()));
                        }
                      },
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
