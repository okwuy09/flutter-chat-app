import 'package:flash_chat/components/roundbutton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool? showSpin = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(
              child: Builder( builder: (context) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
          tag: 'logo',
          child: Container(
            height: 160.0,
            child: Image.asset('images/logo.png'),
          ),
                    ),
                    SizedBox(
          height: 40.0,
                    ),
                    TextField(
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.center,
          onChanged: (value) {
            email = value;
          },
          decoration: kTextFieldDecoration.copyWith(
            hintText: 'Enter your email',
          ),
                    ),
                    SizedBox(
          height: 8.0,
                    ),
                    TextField(
          textAlign: TextAlign.center,
          obscureText: true,
          onChanged: (value) {
            password = value;
          },
          decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your passward'),
                    ),
                    SizedBox(
          height: 15.0,
                    ),
                    RoundedButton(
          title: 'Register',
          color: Colors.blueAccent,
          onpressed: () async {
            final progress = ProgressHUD.of(context);
                        progress?.showWithText('Loading...');
                        Future.delayed(Duration(seconds: 1), () {
                          progress?.dismiss();
                        });
            try {
                 await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                Navigator.pushNamed(context, ChatScreen.id);
            } catch (e) {
                print(e);
            }
          },
                    ),
                  ],
                ),
            ),
              ),
      ),
    );
  }
}
