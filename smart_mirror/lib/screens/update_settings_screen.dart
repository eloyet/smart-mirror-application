import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:smart_mirror/reusable_widgets/reusable_widget.dart';
import 'package:smart_mirror/utils/my_clipper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_mirror/screens/signin_screen.dart';
import 'package:smart_mirror/service/storage_service.dart';
import '../service/auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

//
 final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference personCollection =
      FirebaseFirestore.instance.collection("Person");

  late final String? uid;
  User? userData = FirebaseAuth.instance.currentUser;




class updateScreen extends StatefulWidget {
  const updateScreen({Key? key}) : super(key: key);

  @override
  _updateScreenState createState() => _updateScreenState();
}

class _updateScreenState extends State<updateScreen> {
  final TextEditingController _passwordTextController = TextEditingController();    //  for password
  final TextEditingController _newPasswordTextController =       //  for new password
      TextEditingController();
  final TextEditingController _confirmpasswordTextController =       //  for confirm password
      TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;  //  for firebase auth
  final AuthService _authService = AuthService();     //  for auth service

  void _logOut() async {     //  for logout
    await _authService.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => SignInScreen()), (_) => false);
  }

  Future<bool> _changePassword() async {     //  for change password
    bool flag = false;
    User user = await FirebaseAuth.instance.currentUser!;
    String? email = user.email;

    try {
      UserCredential userCredential =    //  for change password
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: _passwordTextController.text,
      );

      user.updatePassword(_newPasswordTextController.text).then((_) {      //  for update password
        //print("Successfully changed password");
      }).catchError((error) {
        //print("Password can't be changed" + error.toString());
        flag = true;
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    } on FirebaseAuthException catch (e) {      //  for firebase auth exception
      if (e.code == 'user-not-found') {
        //print('No user found for that email.');
      } else if (e.code == 'wrong-password') {          //  for wrong password
        //print('Wrong password provided for that user.');
        flag = true;
      }
    }
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return /*  MaterialApp(
      home:  */
        Scaffold(
      backgroundColor: Colors.blueGrey[800],    //  for background color
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.width * 0.15,
        backgroundColor: Colors.transparent,
        title: Text('Sign-In Settings'),    //  for title
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            child: ClipPath(     //  for designing the background
              clipper: MyClipper(),
              child: Container(
                color: Colors.blueGrey[700],
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Positioned(
            child: ClipPath(       //   for designing the background
              clipper: MySecondClipper(),
              child: Container(
                color: Colors.blueGrey,
                width: double.infinity,
                height: 800,
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,    //media query for width
              height: MediaQuery.of(context).size.height,    //media query for height
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Column(
                  children: <Widget>[    
                    reusableTitleField("CHANGE PASSWORD", false),    
                    const SizedBox(height: 30),
                    reusableTextField( //  for password
                        "Enter Old Password",
                        Icons.lock_open_outlined,
                        true,
                        _passwordTextController),
                    const SizedBox(height: 20),
                    reusableTextField("Enter New Password", Icons.lock_outlined,  //  for new password
                        true, _newPasswordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                        "Confirm New Password", //  for confirm password
                        Icons.lock_reset_outlined,
                        true,
                        _confirmpasswordTextController),
                    const SizedBox(
                      height: 30,
                    ),
                    updateButton(context, () async {
                      if (_passwordTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter the old password.'),    //  if old password is empty
                          ),
                        );
                        return;
                      }
                      if (_newPasswordTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a new password.'),   //  if new password is empty
                          ),
                        );
                        return;
                      }
                      if (_passwordTextController.text ==
                          _newPasswordTextController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Old password cannot be same as new password.'),     //  if old password is same as new password
                          ),
                        );
                        return;
                      }
                      if (_newPasswordTextController.text !=
                          _confirmpasswordTextController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwords do not match.'),  //  if new password and confirm password do not match
                          ),
                        );
                        return;
                      }
                      bool flag = await _changePassword();
                      if (flag == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Wrong password provided.'), // if wrong password is provided
                          ),
                        );
                      } else {
                        _logOut();
                      }
                    }),
                    const SizedBox(
                      height: 40,
                    ),
                    reusableTitleField("DELETE ACCOUNT", false), //  for delete account
                    reusableTitleField(
                        "Once you delete your account, there is no going \nback.Please be certain.", 
                        true),
                    const SizedBox(
                      height: 10,
                    ),
                    deleteAccountButton(context, () {
                      try {
                        FirebaseAuth.instance.currentUser?.delete();
                      } on FirebaseAuthException catch (e) { //  for firebase auth exception
                        if (e.code == 'requires-recent-login') {
/*                           print(
                              'The user must reauthenticate before this operation can be executed.'); */
                        }
                      }
                          User? user = _auth.currentUser;
                          final uid = user!.uid;
                      try {
                            firebase_storage.FirebaseStorage.instance.ref('test/$uid').delete();
                          } catch (e) {
                            print("error deleting photo");
                          }
                        
                      _logOut();
                      /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen())); */
                    })
                  ],
                ),
              ))),
        ],
      ),
    ); //,
    //);
  }
}
