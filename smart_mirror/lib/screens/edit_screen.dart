import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:smart_mirror/reusable_widgets/reusable_widget.dart';
import 'package:smart_mirror/screens/home_screen.dart';
import 'package:smart_mirror/service/storage_service.dart';
import 'package:smart_mirror/service/auth.dart';
import 'package:smart_mirror/utils/my_clipper.dart';
import 'package:flutter/cupertino.dart';
// The edit screen is a screen where user information
//can be viewed and updated at the same time.

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  //This declaration is for authentication service
  //inside of the database management system...
  CollectionReference users = FirebaseFirestore.instance.collection('Person');
  final AuthService _authService = AuthService();
  final Storage storage = Storage();
  //This part is to reach database instances about current user...
  //But, Firebase authentication part can be reachedin this case...
  User userData = FirebaseAuth.instance.currentUser!;
  // getUserData() function is for reading data from database.
  //(user id and email information)
  String selectedValue_country = "";
  String selectedValue_gender = "";

  //The part where the definitions of the necessary
  // variables for certain textfields are made

  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _userSurnameTextController =
      TextEditingController();
  DateTime birth = DateTime.now();
  var formate1 ='';
  //final TextEditingController _genderTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  DateTime now = new DateTime.now();

  // This part contains birthdate information of user...
  // The part where the date scale is determined...
  List<Widget> genders = [
    const Text("Please Select a Gender"),
    const Text("Female"),
    const Text("Male"),
    const Text("I do not want to specify."),
  ];

  List<Widget> countries = [
    const Text("Please Select a City"),
    const Text("Adana"),
    const Text("Adıyaman"),
    const Text("Afyonkarahisar"),
    const Text("Ağrı"),
    const Text("Aksaray"),
    const Text("Amasya"),
    const Text("Ankara"),
    const Text("Antalya"),
    const Text("Ardahan"),
    const Text("Artvin"),
    const Text("Aydın"),
    const Text("Balıkesir"),
    const Text("Bartın"),
    const Text("Batman"),
    const Text("Bayburt"),
    const Text("Bilecik"),
    const Text("Bingöl"),
    const Text("Bitlis"),
    const Text("Bolu"),
    const Text("Burdur"),
    const Text("Bursa"),
    const Text("Çanakkale"),
    const Text("Çankırı"),
    const Text("Çorum"),
    const Text("Denizli"),
    const Text("Diyarbakır"),
    const Text("Düzce"),
    const Text("Edirne"),
    const Text("Elazığ"),
    const Text("Erzincan"),
    const Text("Erzurum"),
    const Text("Eskişehir"),
    const Text("Gaziantep"),
    const Text("Giresun"),
    const Text("Gümüşhane"),
    const Text("Hakkari"),
    const Text("Hatay"),
    const Text("Iğdır"),
    const Text("Isparta"),
    const Text("İstanbul"),
    const Text("İzmir"),
    const Text("Kahramanmaraş"),
    const Text("Karabük"),
    const Text("Karaman"),
    const Text("Kars"),
    const Text("Kastamonu"),
    const Text("Kayseri"),
    const Text("Kilis"),
    const Text("Kırıkkale"),
    const Text("Kırklareli"),
    const Text("Kırşehir"),
    const Text("Kocaeli"),
    const Text("Konya"),
    const Text("Kütahya"),
    const Text("Malatya"),
    const Text("Manisa"),
    const Text("Mardin"),
    const Text("Mersin"),
    const Text("Muğla"),
    const Text("Muş"),
    const Text("Nevşehir"),
    const Text("Niğde"),
    const Text("Ordu"),
    const Text("Osmaniye"),
    const Text("Rize"),
    const Text("Sakarya"),
    const Text("Samsun"),
    const Text("Siirt"),
    const Text("Sinop"),
    const Text("Sivas"),
    const Text("Şanlıurfa"),
    const Text("Şırnak"),
    const Text("Tekirdağ"),
    const Text("Tokat"),
    const Text("Trabzon"),
    const Text("Tunceli"),
    const Text("Uşak"),
    const Text("Van"),
    const Text("Yalova"),
    const Text("Yozgat"),
    const Text("Zonguldak"),
  ];

//////////////////////////////////////////////////////////////////////////////////////
  var userName = '';
  var userSurname = '';
  var password = '';
  var country = '';
  Timestamp? birthDate;
  var gender = '';
  var email = '';
  String dateInfo = "";

  static get gelenVeri => null;
  Future getText() async {
    FirebaseFirestore.instance
        .collection("Person")
        .doc(userData
            .uid) //userData.uid is the user's id which is unique for each user
        .get()
        .then((gelenVeri) {
      setState(() {
        userName = gelenVeri.data()![
            'userName']; // userName is the user's name which is stored in the database
        userSurname = gelenVeri.data()![
            'userSurname']; // userSurname is the user's surname which is stored in the database
        password = gelenVeri.data()![
            'password']; //      password is the user's password which is stored in the database
        country = gelenVeri.data()!['country'];
        birthDate = gelenVeri.data()!['birth'];
        birth = birthDate!.toDate();
        formate1 = "${birth.day}-${birth.month}-${birth.year}";

        gender = gelenVeri.data()!['gender'];
        email = gelenVeri.data()!['email'];
      });
    });
  }



  @override
  void initState() {
    super.initState();
    getText();
  }

  // No field should be left blank if changes need to be made...
  // The statement that the value received cannot
  // be null is written for the situation that will not be left blank...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.width * 0.15,
        backgroundColor: Colors.transparent,
        title: const Text('Personal Settings'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        elevation: 0,
      ),
      body: Stack(
        // Container body of the application screen...
        children: <Widget>[
          Positioned(
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
            child: ClipPath(
              clipper: MySecondClipper(),
              child: Container(
                color: Colors.blueGrey,
                width: double.infinity,
                height: 800,
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 1,
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 35, 30, 40),
                child: Column(
                  children: <Widget>[
                    // Textbox declaration with name entry and name information...
                    reusableTextField(userName, Icons.person_outline, false,
                        _userNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    // Textbox declaration with surname entry and surname information...
                    reusableTextField(userSurname, Icons.person_outline, false,
                        _userSurnameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                 
                    RaisedButton(
                      //for date picker
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90)),
                      onPressed: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (_) => Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .copyWith()
                                                  .size
                                                  .height *
                                              0.27,
                                          child: CupertinoPicker(
                                            children: countries,
                                            onSelectedItemChanged: (value) {
                                              Text text =
                                                  countries[value] as Text;
                                              selectedValue_country =
                                                  text.data.toString();
                                              country = selectedValue_country;
                                              setState(() {});
                                            },
                                            itemExtent: 35,
                                            diameterRatio: 1,
                                            looping: true,
                                          )),
                                      CupertinoButton(
                                        child: const Text('Select'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      )
                                    ],
                                  ),
                                ));
                      },
                      child: Container( //for city picker
                        alignment: Alignment.center,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.map_outlined,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "  $country",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      color: Colors.blue[100],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      //for date picker
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90)),
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            theme: const DatePickerTheme(
                              containerHeight: 210,
                            ),
                            showTitleActions: true,
                            minTime: DateTime(1900, 1, 1),
                            maxTime: DateTime(now.year, 12, 31), onConfirm: (date) {
                          dateInfo =
                              '${date.year} - ${date.month} - ${date.day}';
                          String todayInfo =
                              '${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}';

                          if (dateInfo != todayInfo) {
                            birth = date;
                          }

                          setState(() {});
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      //for date picker
                                      const Icon(
                                        Icons.cake_outlined,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "   $formate1",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      color: Colors.blue[100],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      //for gender picker
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90)),
                      onPressed: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (_) => Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .copyWith()
                                                  .size
                                                  .height *
                                              0.27,
                                          child: CupertinoPicker(
                                            children: genders,
                                            onSelectedItemChanged: (value) {
                                              Text text =
                                                  genders[value] as Text;
                                              selectedValue_gender =
                                                  text.data.toString();
                                              gender = selectedValue_gender;
                                              setState(() {});
                                            },
                                            itemExtent: 35,
                                            diameterRatio: 1,
                                            looping: false,
                                          )),
                                      CupertinoButton(
                                        child: const Text('Select'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      )
                                    ],
                                  ),
                                ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.man,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "  $gender",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      color: Colors.blue[100],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // The part where the photo can be uploaded in png, jpg, or jpeg format...
                    // This part is important for face recognition...
                    ElevatedButton.icon(
                      label: const Text('  Upload Photo'),
                      icon: const Icon(Icons.camera_alt_outlined,
                          color: Colors.black),
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        alignment: Alignment.centerLeft,
                        fixedSize: const Size(480, 60),
                        primary: Colors.blue[100],
                        onPrimary: Colors.black,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(90),
                        ),
                      ),
                      onPressed: () async {
                        final results = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['png', 'jpg', 'jpeg'],
                        );
                        if (results == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No file selected.'),
                            ),
                          );
                          return;
                        }
                        final path = results.files.single.path!;
                        final fileName = results.files.single.name;

                        storage
                            .uploadFile(path, fileName)
                            .then((value) => print('Done'));
                      },
                      //child: const Text('Upload Photo'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // A drop down box with two options is used for gender selection...

                    const SizedBox(
                      height: 20,
                    ),
                    // The purpose of this button is to update the user's
                    //  personal information...
                    //  But now it has no function...

                    EditInformationButton(context, false, () {
                      if (_userNameTextController.text == '') {  //if the user name is empty then do not update the user name
                        _userNameTextController.text = userName;
                      }
                      if (_userSurnameTextController.text == '') {  //if the user surname is empty then do not update the user surname
                        _userSurnameTextController.text = userSurname;
                      }
                      if (_addressTextController.text == '') {  //if the address is empty then do not update the address
                        _addressTextController.text = country;
                      }
                      if (selectedValue_country == '') { //if the country is empty then do not update the country
                        selectedValue_country = country;
                      }
                      if (selectedValue_gender == '') {  // if the gender is empty then do not update the gender
                        selectedValue_gender = gender;
                      }
                          if (selectedValue_gender == 'Please Select a Gender') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You have to choose a gender.'),
                          ),
                        );
                        return;
                      }
                        if (selectedValue_country == 'Please Select a City') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You have to choose a city.'),
                          ),
                        );
                        return;
                      } 
                      print(birth);

                      // if (birth.toString() == deneme) {
                      //   birth = dateInfo as DateTime;
                      // }

                      _authService
                          .updatePerson(  //save the user's information to the database
                              _userNameTextController.text,
                              _userSurnameTextController.text,
                              selectedValue_country,
                              selectedValue_gender,
                              birth)
                          // If inside of textfield is null then do not update from firestore database...
                          .then((value) {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                    })
                  ],
                ),
              )))
        ],
      ),
    );
  }
}
