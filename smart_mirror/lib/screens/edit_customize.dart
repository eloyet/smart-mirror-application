import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_mirror/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:smart_mirror/screens/reminder.dart';
import 'package:smart_mirror/utils/my_clipper.dart';
import 'package:smart_mirror/service/auth.dart';

import '../service/storage_service.dart';
import 'home_screen.dart';
//this screen appears when the user clicks on the edit button in the home screen
//user can edit their preferences here
class EditCustomizeScreen extends StatefulWidget {
  const EditCustomizeScreen({Key? key}) : super(key: key);

  @override
  _EditCustomizeScreenState createState() => _EditCustomizeScreenState();
}

class _EditCustomizeScreenState extends State<EditCustomizeScreen> {
  
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CollectionReference users = FirebaseFirestore.instance.collection('Person');
  final AuthService _authService = AuthService();
  final Storage storage = Storage();
  //This part is to reach database instances about current user...
  //But, Firebase authentication part can be reachedin this case...
  User userData = FirebaseAuth.instance.currentUser!;
 // the prefences of user are stored in this variable retrieved from the database
  var dwtime = '';
  var dwdate = '';
  var dwweather = '';
  var dwdailynews = '';
  var dwexchange = '';
  var dwmotivational = '';
  var dwreminder = '';
  var dwwelcome ='';
  var dwfood = '';
  


  static get gelenVeri => null;
  Future getText() async {  //this is to get the preferences of the user from the database
    FirebaseFirestore.instance
        .collection("Person")
        .doc(userData
            .uid) // <-- Doc ID where data should be updated.
        .get()
        .then((gelenVeri) {
      setState(() {
         dwtime = gelenVeri.data()![ // <-- Updated data
            'time_widget'];   
      
        dwdate = gelenVeri.data()![
            'date_widget'];
        dwweather = gelenVeri.data()![
            'weather_widget']; 
        dwdailynews = gelenVeri.data()![
            'daily_widget'];
        dwexchange = gelenVeri.data()![
            'exchange_widget']; 
        dwmotivational = gelenVeri.data()![
            'motivational_widget'];
        dwreminder = gelenVeri.data()![
            'reminder_widget']; 
        dwwelcome = gelenVeri.data()![
            'welcome_widget'];    
        dwfood = gelenVeri.data()![
            'food_widget'];      

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
    print("time:"+dwreminder.toString());
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
                    value: dwtime == 'true' ? true : false,  //if the user has selected the widget, the switch will be on else off
                    onChanged: (bool value) {
                      setState(() {
                        dwtime = value.toString();
                      });
                    },
                    title: const Text(
                      'Time',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade
                      ),
                    ),
                    secondary: const Icon(
                      Icons.access_time,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: dwdate == 'true' ? true : false,
                    onChanged: (bool value) {
                      setState(() {
                        dwdate = value.toString();
                      });
                    },
                    title: const Text(
                      'Date',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade
                      ),
                    ),
                    secondary: const Icon(
                      Icons.date_range_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: dwweather == 'true' ? true : false,
                    onChanged: (bool value) {
                      setState(() {
                        dwweather = value.toString();
                      });
                    },
                    title: const Text(
                      'Weather',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade
                      ),
                    ),
                    secondary: const Icon(
                      Icons.wb_sunny_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: dwdailynews == 'true' ? true : false,
                    onChanged: (bool value) {
                      setState(() {
                        dwdailynews = value.toString();
                      });
                    },
                    title: const Text(
                      'Daily News',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade
                      ),
                    ),
                    secondary: const Icon(
                      Icons.newspaper_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: dwexchange == 'true' ? true : false,
                    onChanged: (bool value) {
                      setState(() {
                        dwexchange = value.toString();
                      });
                    },
                    title: const Text(
                      'Exchange',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade
                      ),
                    ),
                    secondary: const Icon(
                      Icons.currency_exchange_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: dwmotivational == 'true' ? true : false,
                    onChanged: (bool value) {
                      setState(() {
                        dwmotivational = value.toString();
                      });
                    },
                    title: const Text(
                      'Motivational Text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade
                      ),
                    ),
                    secondary: const Icon(
                      Icons.article_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: dwreminder == 'true' ? true : false,
                    onChanged: (bool value) {
                      setState(() {
                        dwreminder = value.toString();
                      });
                    },
                    title: const Text(
                      'Reminder',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade
                      ),
                    ),
                    secondary: const Icon(
                      Icons.text_fields_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: dwwelcome == 'true' ? true : false,
                    onChanged: (bool value) {
                      setState(() {
                        dwwelcome = value.toString();
                      });
                    },
                    title: const Text(
                      'Welcome Message',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade

                      ),
                    ),
                    secondary: const Icon(
                      Icons.message_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SwitchListTile(
                    value: dwfood == 'true' ? true : false,
                    onChanged: (bool value) {
                      setState(() {
                        dwfood = value.toString();
                      });
                    },
                    title: const Text(
                      'Food Recommendation',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.fade
                      ),
                    ),
                    secondary: const Icon(
                      Icons.fastfood_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.006,
                  ),
                  AddReminderButton(context, false, () {
                    
                      if(dwreminder == "false"){
                         ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please enable the reminder to add a reminder'),
                              ),
                            );
                            return;
                      }
                      else{
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReminderScreen())); 
                      }
                   
                  }),
                  EditCustomizeMirrorButton(context, false, () { //save the customized settings to the database
                    _authService
                        .EditCustomizeButton(
                      dwtime.toString(),
                      dwdate.toString(),
                      dwweather.toString(),
                      dwdailynews.toString(),
                      dwexchange.toString(),
                      dwmotivational.toString(),
                      dwreminder.toString(),
                      dwwelcome.toString(),
                      dwfood.toString(),
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