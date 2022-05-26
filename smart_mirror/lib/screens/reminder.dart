import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_mirror/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:smart_mirror/utils/my_clipper.dart';
import '../service/auth.dart';
import '../service/storage_service.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _ReminderScreenState extends State<ReminderScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('Person');
  final AuthService _authService = AuthService();
  final Storage storage = Storage();
  //This part is to reach database instances about current user...
  //But, Firebase authentication part can be reachedin this case...
  User userData = FirebaseAuth.instance.currentUser!;
  final TextEditingController _reminderTextController1 =
      TextEditingController();
  final TextEditingController _reminderTextController2 =
      TextEditingController();
  final TextEditingController _reminderTextController3 =
      TextEditingController();

  var reminder1 = '';
  var reminder2 = '';
  var reminder3 = '';

  static get gelenVeri => null;
  Future getText() async {
    FirebaseFirestore.instance
        .collection("Person")
        .doc(userData
            .uid) // This is to reach database instances about current user...
        .get()
        .then((gelenVeri) {
      setState(() {
        reminder1 = gelenVeri.data()!['reminder1']; //
        reminder2 = gelenVeri.data()!['reminder2']; //
        reminder3 = gelenVeri.data()!['reminder3']; //
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.width * 0.15,
        backgroundColor: Colors.transparent,
        title: const Text('Add Reminder'), //  title of the app bar
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
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                      reminder1,
                      Icons.add_circle_outline_sharp,
                      false, //  reusable text field
                      _reminderTextController1),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                      reminder2,
                      Icons.add_circle_outline_sharp,
                      false, //  reusable text field
                      _reminderTextController2),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                      reminder3,
                      Icons.add_circle_outline_sharp,
                      false, //  reusable text field
                      _reminderTextController3),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  customizeMirrorButton(context, false, () {
                    if (_reminderTextController1.text == '') {
                      _reminderTextController1.text = reminder1;
                    }
                    if (_reminderTextController2.text == '') {
                      _reminderTextController2.text = reminder2;
                    }
                    if (_reminderTextController3.text == '') {
                      _reminderTextController3.text = reminder3;
                    }
                    _authService.reminderAdding(
                        _reminderTextController1.text,
                        _reminderTextController2.text,
                        _reminderTextController3.text);
                    Navigator.of(context).pop();
                  }),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
