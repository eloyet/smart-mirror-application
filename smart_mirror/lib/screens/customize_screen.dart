import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_mirror/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:smart_mirror/screens/reminder.dart';
import 'package:smart_mirror/utils/my_clipper.dart';
import 'package:smart_mirror/service/auth.dart';

import '../service/storage_service.dart';
import 'home_screen.dart';
//Customize Screen is the screen that allows the user to customize their mirror
class CustomizeScreen extends StatefulWidget {
  const CustomizeScreen({Key? key}) : super(key: key);

  @override
  _CustomizeScreenState createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {   
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CollectionReference users = FirebaseFirestore.instance.collection('Person'); //Collection that holds the users
  final AuthService _authService = AuthService();  
  final Storage storage = Storage(); 
  //This part is to reach database instances about current user...
  //But, Firebase authentication part can be reachedin this case...
  User userData = FirebaseAuth.instance.currentUser!;
 //This screen appears only when the user is signed up and the all widgets came as default values 
 //swithching the values will change the widgets in the mirror
 //SwitchListTile is a widget that allows the user to switch the values
  bool wtime = false;           
  bool wdate = false;
  bool wweather = false;
  bool wdailynews = false;
  bool wexchange = false;
  bool wmotivational = false;
  bool wreminder = false;
  bool wwelcome = false;
  bool wfood = false;
  //user can add reminder to the mirror 
  String reminder1 = '';
  String reminder2 = '';
  String reminder3 = '';

  @override
  Widget build(BuildContext context) {
    
        return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.width * 0.15,
        backgroundColor: Colors.transparent,
        title: const Text('Customize the Mirror'), //  title of the app bar
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey[800],
      body: Stack(
        children: <Widget>[
          Positioned(
            // for designing the background
            child: ClipPath(
              clipper: MyClipper(),
              child: Container(
                color: Colors.blueGrey[700],
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Positioned(
            // for designing the background
            child: ClipPath(
              clipper: MySecondClipper(),
              child: Container(
                color: Colors.blueGrey,
                width: double.infinity,
                height: 800,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width /
                  15), //MediaQuery provides widget to rebuild automatically
              child: Column(
                //mainAxisSize: MainAxisSize.max,

                children: <Widget>[
                  SwitchListTile(
                    value: wtime,
                    onChanged: (bool value) {
                      setState(() {
                        wtime = value;
                      });
                    },
                    title: const Text(
                      'Time',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    secondary: const Icon(
                      Icons.access_time,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: wdate,
                    onChanged: (bool value) {
                      setState(() {
                        wdate = value;
                      });
                    },
                    title: const Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    secondary: const Icon(
                      Icons.date_range_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: wweather,
                    onChanged: (bool value) {
                      setState(() {
                        wweather = value;
                      });
                    },
                    title: const Text(
                      'Weather',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    secondary: const Icon(
                      Icons.wb_sunny_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: wdailynews,
                    onChanged: (bool value) {
                      setState(() {
                        wdailynews = value;
                      });
                    },
                    title: const Text(
                      'Daily News',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    secondary: const Icon(
                      Icons.newspaper_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: wexchange,
                    onChanged: (bool value) {
                      setState(() {
                        wexchange = value;
                      });
                    },
                    title: const Text(
                      'Exchange',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    secondary: const Icon(
                      Icons.currency_exchange_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: wmotivational,
                    onChanged: (bool value) {
                      setState(() {
                        wmotivational = value;
                      });
                    },
                    title: const Text(
                      'Motivational Text',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    secondary: const Icon(
                      Icons.article_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: wreminder,
                    onChanged: (bool value) {
                      setState(() {
                        wreminder = value;
                      });
                    },
                    title: const Text(
                      'Reminder',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    secondary: const Icon(
                      Icons.text_fields_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: wwelcome,
                    onChanged: (bool value) {
                      setState(() {
                        wwelcome = value;
                      });
                    },
                    title: const Text(
                      'Welcome Message',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    secondary: const Icon(
                      Icons.message_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: wfood,
                    onChanged: (bool value) {
                      setState(() {
                        wfood = value;
                      });
                    },
                    title: const Text(
                      'Food Recommendation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    secondary: const Icon(
                      Icons.fastfood_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  addReminderButton(context, false, () {
                      if(wreminder == false){
                         ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please enable the reminder to add a reminder'), //if the reminder is not enabled then show this message
                              ),
                            );
                            return;
                      }
                      else{
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReminderScreen())); //navigate to the reminder screen
                      }
                   
                  }),
                  customizeMirrorButton(context, false, () { //saved the preferences to firebase
                    _authService
                        .customizeButton(
                      wtime.toString(),
                      wdate.toString(),
                      wweather.toString(),
                      wdailynews.toString(),
                      wexchange.toString(),
                      wmotivational.toString(),
                      wreminder.toString(),
                      wwelcome.toString(),
                      wfood.toString(),
                      reminder1.toString(),
                      reminder2.toString(),
                      reminder3.toString(),
                    ) // If inside of textfield is null then do not update from firestore database...
                        .then((value) {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
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