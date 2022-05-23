// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_mirror/reusable_widgets/reusable_widget.dart';
import 'package:smart_mirror/screens/forgotPassword_screen.dart';
import 'package:smart_mirror/screens/home_screen.dart';
import 'package:smart_mirror/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:smart_mirror/utils/my_clipper.dart';
 // the following is the code for the signin screen
 // user can signin with email and password or signup with email and password 
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blueGrey[800],
        body: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Positioned(
              child: ClipPath(
                clipper: MyClipper(),
                child: Container(
                  color: Colors.blueGrey[700],
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1,
                ),
              ),
            ),
            Positioned(
              child: ClipPath(
                clipper: MySecondClipper(),
                child: Container(
                  color: Colors.blueGrey,
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1,
                ),
              ),
            ),
            SingleChildScrollView(
              // width: MediaQuery.of(context).size.width * 1,
              //   height: MediaQuery.of(context).size.height * 0.09,
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 13),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30),
                    Image.asset(
                      'assets/logo.png',
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    reusableTextField("Enter Email", Icons.person_outline,
                        false, _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outline,
                        true, _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    signInSignUpButton(context, true, () async {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                        if (error.toString() ==
                            "[firebase_auth/unknown] Given String is empty or null") {
                          _scaffoldKey.currentState!
                              .showSnackBar(const SnackBar(
                            content: Text('Given String is empty or null !'),
                          ));
                          return;
                        }
                        if (error.toString() ==
                            "[firebase_auth/invalid-email] The email address is badly formatted.") {
                          _scaffoldKey.currentState!
                              .showSnackBar(const SnackBar(
                            content:
                                Text('The email address is badly formatted !'),
                          ));
                          return;
                        }
                        if (error.toString() ==
                            "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
                          _scaffoldKey.currentState!
                              .showSnackBar(const SnackBar(
                            content: Text('The password or email is invalid !'),
                          ));
                          return;
                        }
                        if (error.toString() ==
                            "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
                          _scaffoldKey.currentState!
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'There is no user record corresponding to this identifier !'),
                          ));
                          return;
                        }
                        if (error.toString() ==
                            "[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.") {
                          _scaffoldKey.currentState!
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'We have blocked all requests from this device due to unusual activity. Try again later.'),
                          ));
                          return;
                        }
                      });
                    }),
                    InkWell(
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onTap: () => Navigator.of(context).push( //navigate to signup screen
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()))),
                    InkWell(
                        child: const Text("Forgot Password?"),
                        onTap: () => Navigator.of(context).push(  //navigate to forgot password screen
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen()))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
