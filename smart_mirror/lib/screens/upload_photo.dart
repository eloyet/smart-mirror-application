import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_mirror/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:smart_mirror/screens/customize_screen.dart';
import 'package:smart_mirror/screens/signin_screen.dart';
import 'package:smart_mirror/utils/my_clipper.dart';

import '../service/storage_service.dart';
// the following is the code for the upload photo of the user
class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({Key? key}) : super(key: key);

  @override
  _UploadPhotoScreenState createState() => _UploadPhotoScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  bool uploadValue = false;
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.width * 0.15,
        backgroundColor: Colors.transparent,
        title: const Text('Upload Photo'), //  title of the app bar
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
                    height: 180,
                  ),
                  InkWell(
                    child: const Text(
                      "Please upload a photo of yourself \n     that clearly shows your face.",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton.icon(
                    //for upload photo button
                    label: const Text('Upload Photo'),
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
                        //for upload photo
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg', 'jpeg'],
                      );
                      if (results == null) {
                        uploadValue = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No file selected.'),
                            //for upload photo if no file selected
                          ),
                        );
                        return;
                      }
                      final path = results.files.single.path!;
                      final fileName = results.files.single.name;

                      storage.uploadFile(path, fileName).then(
                            (value) => uploadValue = true,
                          ); //for upload photo to firebase storage
                    },
                    //child: const Text('Upload Photo'),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  MaterialButton(
                    // button for customizing the mirror
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.07,
                    color: Colors.black,
                    textColor: Colors.white,
                    child: const Text("DONE", style: TextStyle(fontSize: 19)),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(90),
                    ),
                    onPressed: () {
                      if (uploadValue == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CustomizeScreen(),
                          ),
                        );
                      } else if(uploadValue == false) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please upload a photo of yourself that clearly shows your face.'),
                          ),
                        );
                        return;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}