import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {  //class for the connection with the firebase and the storage
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference personCollection =
      FirebaseFirestore.instance.collection("Person");

  late final String? uid;
  User? userData = FirebaseAuth.instance.currentUser;



  Storage({this.uid});

  Future<void> uploadFile(String destination, String fileName) async {  //upload the photo of the user with the uid of the user
    User? user = _auth.currentUser;
    final uid = user!.uid;
    File file = File(destination);
      final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
    try {
      await storage.ref('test/$uid').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

 


}
