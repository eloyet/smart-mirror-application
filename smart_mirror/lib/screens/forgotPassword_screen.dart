
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_mirror/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:smart_mirror/utils/my_clipper.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.width * 0.15,
        backgroundColor: Colors.transparent,
        title: const Text('Forgot Password'), //  title of the app bar
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        elevation: 0,
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.blueGrey[800],
      body: Stack(
        children: <Widget>[
          Positioned(
            child: ClipPath(
              clipper: MyClipper(), //  for designing the background
              child: Container(
                color: Colors.blueGrey[700],
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Positioned(
            child: ClipPath(
              clipper: MySecondClipper(),
              child: Container(
                color: Colors.blueGrey,
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 60,
                  ),
                  reusableTextField("Enter Email", Icons.person_outline, false, //  reusable text field
                      _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  forgotPasswordButton(context, () async { //  forgot password button
                    if (_emailTextController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You have to enter an email.'),
                        ),
                      );
                      return;
                    }
                    await FirebaseAuth.instance.sendPasswordResetEmail( //  send password reset email to the user
                        email: _emailTextController.text);
                    Navigator.of(context).pop();
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}