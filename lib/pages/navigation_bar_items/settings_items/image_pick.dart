import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:health_app/elements/loadingdialog.dart';
import 'package:health_app/elements/mainurl.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ImgPicker extends StatefulWidget {
  const ImgPicker({super.key});

  @override
  State<ImgPicker> createState() => _ImgPickerState();
}

String email = '';
Future sharedpref() async {
  var pref = await SharedPreferences.getInstance();
  email = pref.getString('email') ?? '';
}

class _ImgPickerState extends State<ImgPicker> {
  MyUrl ob = MyUrl();

  Future<void> uploadimage(String email, String imgUrl) async {
    Map data = {
      "email": email,
      "img_url": imgUrl,
    };
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const LoadingDialog();
        });

    try {
      var response = await http
          .post(Uri.http(ob.mainurl, "${ob.suburl}img_upload.php"), body: data);
      var jsondata = jsonDecode(response.body);
      if (jsondata["status"] == 'true') {
        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: jsondata["msg"],
        );
        Navigator.pop(context);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  var imageUrl = "";

  pickimage(String typ) async {
    ImagePicker imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(
        source: typ == 'cam' ? ImageSource.camera : ImageSource.gallery);
    print('${file?.path}');

    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    //store file
    try {
      await referenceImageToUpload.putFile(File(file!.path));

      imageUrl = await referenceImageToUpload.getDownloadURL();
      setState(() {
        sharedpref().whenComplete(() {
          uploadimage(email, imageUrl);
        });
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: imageUrl == ""
                  ? const Image(
                      image: AssetImage('lib/assets/blank_profile.jpg'),
                      fit: BoxFit.cover)
                  : Image(image: NetworkImage(imageUrl), fit: BoxFit.cover),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(colors: [
                        Colors.yellowAccent.withOpacity(0.5),
                        Colors.yellowAccent.withOpacity(0.7),
                      ])),
                  width: 70,
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            pickimage('cam');
                          },
                          icon: const Icon(Icons.camera)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(colors: [
                        Colors.yellowAccent.withOpacity(0.5),
                        Colors.yellowAccent.withOpacity(0.7),
                      ])),
                  width: 70,
                  child: IconButton(
                      onPressed: () {
                        pickimage('fil');
                      },
                      icon: const Icon(Icons.file_upload)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
