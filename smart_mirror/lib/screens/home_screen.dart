// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:smart_mirror/screens/customize_screen.dart';
import 'package:smart_mirror/screens/edit_customize.dart';
import 'package:smart_mirror/screens/edit_screen.dart';
import 'package:smart_mirror/screens/signin_screen.dart';
import 'package:smart_mirror/screens/update_settings_screen.dart';
import 'package:smart_mirror/service/auth.dart';
import 'package:smart_mirror/utils/my_clipper.dart';

final AuthService _authService = AuthService();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: Stack(
        children: <Widget>[
          Positioned(
            // for designing the background
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
            // for designing the background
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
              child: Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width /13), //MediaQuery provides widget to rebuild automatically
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: const AlignmentDirectional(1, -0.85),
                        child: IconButton(
                          //logout button
                          icon: const Icon(
                            Icons.login_rounded,
                            color: Colors.black,
                            size: 33,
                          ),
                          onPressed: () async {
                            // logout function: signout from firebase and navigate to signin screen
                            await _authService.signOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
                                (_) => false);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/home.png',
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: MediaQuery.of(context).size.height * 0.40,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 50),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.height * 0.09,
                        color: Colors.black,
                        textColor: Colors.white,
                        child: const Text("MANAGE PERSONAL SETTINGS",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.fade,),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(90),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditScreen())); // navigate to edit screen
                        },
                      ),
                      const SizedBox(height: 30),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width *
                            0.8, // button for updating the sign-in settings
                        height: MediaQuery.of(context).size.height * 0.09,
                        color: Colors.black,
                        textColor: Colors.white,
                        child: const Text("MANAGE SIGN-IN SETTINGS",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.fade),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(90),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const updateScreen())); //  navigate to update screen
                        },
                      ),
                      const SizedBox(height: 30),
                      MaterialButton(
                        // button for customizing the mirror
                        minWidth: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.09,
                        color: Colors.black,
                        textColor: Colors.white,
                        child: const Text("CUSTOMIZE THE MIRROR",
                        textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.fade),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(90),
                        ),
                        onPressed: () {
                          //print("selected widget"); // this function is not implemented yet
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditCustomizeScreen()));
                        },
                      ),
                    ],
                  ))),
        ],
      ),
    ));
  }
}
