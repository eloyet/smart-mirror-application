import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//this is the code for the connection with the firebase

class AuthService {
  //class for the connection with the firebase and the storage
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference personCollection =
      FirebaseFirestore.instance.collection("Person");

  final String? uid;
  User? userData = FirebaseAuth.instance.currentUser;

  AuthService({this.uid});
  //giriş yap fonksiyonu
  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  //çıkış yap fonksiyonu
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //kayıt ol fonksiyonu
  Future<User?> createPerson(
      String name,
      String surname,
      String email, //createPerson function for the registration
      String password,
      DateTime birth,
      String gender,
      String country,
      bool defaultuser) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore.collection("Person").doc(user.user!.uid).set({
      'userName': name,
      'userSurname': surname,
      'email': email,
      'password': password,
      'birth': birth,
      'gender': gender,
      'country': country,
      'defaultScreen': defaultuser
    });

    return user.user;
  }

  Future<void> updatePerson(
      String userName,
      String userSurname,
      String country, //update the data
      String gender,
      DateTime birth) async {
    var collection = FirebaseFirestore.instance.collection('Person');

    collection
        .doc(userData?.uid) // <-- Doc ID where data should be updated.
        .update({
          'userName': userName,
          'userSurname': userSurname,
          'country': country,
          'gender': gender,
          'birth': birth,
        }) // <-- Updated data

        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));
  }

  Future<void> customizeButton(
      //save the pereferences of customization to the firebase
      String wtime,
      String wdate,
      String wweather,
      String wdailynews,
      String wexchange,
      String wmotivational,
      String wreminder,
      String wwelcome,
      String wfood,
      String reminder1,
      String reminder2,
      String reminder3) async {
    var collection = FirebaseFirestore.instance.collection('Person');
    collection
        .doc(userData?.uid) // <-- Doc ID where data should be updated.
        .update({
          'time_widget': wtime,
          'date_widget': wdate,
          'weather_widget': wweather,
          'daily_widget': wdailynews,
          'exchange_widget': wexchange,
          'motivational_widget': wmotivational,
          'reminder_widget': wreminder,
          'welcome_widget': wwelcome,
          'food_widget': wfood,
          'reminder1': '',
          'reminder2': '',
          'reminder3': '',
        }) // <-- customize mirror data
        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));
  }

  Future<void> editCustomizeButton(
    //save the edited data to the firebase
    String wtime,
    String wdate,
    String wweather,
    String wdailynews,
    String wexchange,
    String wmotivational,
    String wreminder,
    String wwelcome,
    String wfood,
  ) async {
    var collection = FirebaseFirestore.instance.collection('Person');
    collection
        .doc(userData?.uid) // <-- Doc ID where data should be updated.
        .update({
          'time_widget': wtime,
          'date_widget': wdate,
          'weather_widget': wweather,
          'daily_widget': wdailynews,
          'exchange_widget': wexchange,
          'motivational_widget': wmotivational,
          'reminder_widget': wreminder,
          'welcome_widget': wwelcome,
          'food_widget': wfood,
        }) // <-- customize mirror data
        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));
  }

  Future<void> reminderAdding(
    //add the reminder to the firebase
    String _reminderTextController1,
    _reminderTextController2,
    _reminderTextController3,
  ) async {
    var collection = FirebaseFirestore.instance.collection('Person');
    collection
        .doc(userData?.uid) // <-- Doc ID where data should be updated.
        .update({
          'reminder1': _reminderTextController1,
          'reminder2': _reminderTextController2,
          'reminder3': _reminderTextController3,
        }) // <-- customize mirror data
        .then((_) => print('Added'))
        .catchError((error) => print('Adding failed: $error'));
  }
}
