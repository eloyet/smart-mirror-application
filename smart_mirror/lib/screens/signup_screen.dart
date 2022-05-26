import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:smart_mirror/reusable_widgets/reusable_widget.dart';
import 'package:smart_mirror/screens/upload_photo.dart';
import 'package:smart_mirror/service/auth.dart';
import 'package:smart_mirror/utils/my_clipper.dart';

// this is the code for the signup screen
//user should give the details and signup
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _date = "Enter Birthday"; //for date picker
  String _city = "Select City";
  String _gender = "Select Gender";
  String selectedValue_country = "";
  String selectedValue_gender = "";

  final TextEditingController _passwordTextController =
      TextEditingController(); //for password textfield
  final TextEditingController _confirmpasswordTextController =
      TextEditingController(); //for confirm password textfield
  final TextEditingController _emailTextController =
      TextEditingController(); //  for email textfield
  final TextEditingController _userNameTextController =
      TextEditingController(); //for user name textfield
  final TextEditingController
      _userSurnameTextController = //for surname textfield
      TextEditingController();
  DateTime birth = DateTime.now();
  DateTime now = DateTime.now();

  bool defaultuser = false;
/*   final TextEditingController _addressTextController =
      TextEditingController(); */ //for address textfield

  final AuthService _authService = AuthService();

  List<Widget> genders = [
    const Text("Please Select a Gender"),
    const Text("Female"),
    const Text("Male"),
    const Text("I do not want to specify."),
  ];

  ///for auth service
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Sign Up'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            child: ClipPath(
              //for designing the background
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
              //for designing the background
              clipper: MySecondClipper(),
              child: Container(
                color: Colors.blueGrey,
                width: double.infinity,
                height: 800,
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: Padding(
                padding:
                    const EdgeInsets.fromLTRB(30, 35, 30, 40), //for padding
                child: Column(
                  children: <Widget>[
                    reusableTextField(
                        "Enter Name",
                        Icons.person_outline,
                        false, //for name textfield
                        _userNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                        "Enter Surname",
                        Icons.person_outline, //for surname textfield
                        false,
                        _userSurnameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                        "Enter Email",
                        Icons.mail_outline,
                        false, //for email textfield
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                        "Enter Password",
                        Icons.lock_outlined, //  for password textfield
                        true,
                        _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                        "Confirm Password",
                        Icons.lock_outlined, //for confirm password textfield
                        true,
                        _confirmpasswordTextController),
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
                                              _city = selectedValue_country;
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
                                      const Icon(
                                        Icons.map_outlined,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "  $_city",
                                        style: const TextStyle(
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
                            maxTime: DateTime(now.year, 12, 31),
                            onConfirm: (date) {
                          _date = '${date.year} - ${date.month} - ${date.day}';
                          birth = date;
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
                                        "   $_date",
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
                                            children: genders,
                                            onSelectedItemChanged: (value) {
                                              Text text =
                                                  genders[value] as Text;
                                              selectedValue_gender =
                                                  text.data.toString();
                                              _gender = selectedValue_gender;
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
                                      const Icon(
                                        Icons.man,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "  $_gender",
                                        style: const TextStyle(
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
                    signInSignUpButton(context, false, () {
                      //for sign up button

                      if (_userNameTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'You have to enter a name.'), ////if no name selected
                          ),
                        );
                        return;
                      }
                      if (_userSurnameTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'You have to enter a surname.'), ////if no surname selected
                          ),
                        );
                        return;
                      }
                      if (_emailTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'You have to enter an email.'), //if no email selected
                          ),
                        );
                        return;
                      }
                      if (_passwordTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'You have to enter a password.'), //if no password selected
                          ),
                        );
                        return;
                      }
                      if (selectedValue_country.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'You have to choose a city.'), //  if no address selected
                          ),
                        );
                        return;
                      }
                      if (_passwordTextController.text !=
                          _confirmpasswordTextController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Passwords do not match.'), //if passwords do not match
                          ),
                        );
                        return;
                      }
                      if (_date == 'Enter Birthday') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You have to choose a birthday.'),
                          ),
                        );
                        return;
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
                      _authService
                          .createPerson(
                              //for sign up
                              _userNameTextController.text,
                              _userSurnameTextController.text,
                              _emailTextController.text,
                              _passwordTextController.text,
                              birth,
                              selectedValue_gender,
                              selectedValue_country,
                              defaultuser)
                          .then((value) {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UploadPhotoScreen())); //for sign up
                      }).onError((error, stackTrace) async {
                        print("Error ${error.toString()}");
                        if (error.toString() ==
                            "[firebase_auth/invalid-email] The email address is badly formatted.") {
                          //if email is badly formatted
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('The email address is badly formatted.'),
                            ),
                          );
                          return;
                        }
                        if (error.toString() ==
                            "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
                          //if email is already in use
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('The email address is already in use.'),
                            ),
                          );
                          return;
                        }
                        if (error.toString() ==
                            "[firebase_auth/weak-password] Password should be at least 6 characters") {
                          //if password is too short
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Password should be at least 6 characters.'),
                            ),
                          );
                          return;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Succesfully Registered'), //if no error
                            ),
                          );
                        }
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
