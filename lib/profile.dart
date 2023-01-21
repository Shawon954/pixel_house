import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? file;
  ImagePicker image = ImagePicker();
  String? ImagePath;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Profile ',
          style: TextStyle(
              fontSize: 22,
              fontFamily: 'ProstoOne',
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 180,
                  color: Colors.black12,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                        radius: 60,
                        child: Stack(
                          children: [
                            ClipOval(
                              child: ImagePath == null
                                  ? Icon(
                                      Icons.image,
                                      size: 30,
                                    )
                                  : Image.file(
                                      File(ImagePath!),
                                      height: 120,
                                      width: 300,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ],
                        )),
                    Positioned(
                        top: 80,
                        right: 2,
                        child: InkWell(
                          onTap: () {

                            getgall();
                          },
                          child: Icon(
                            Icons.image_rounded,
                            color: Colors.amber,
                          ),
                        )),
                  ],
                ),
                MaterialButton(
                  onPressed: () {

                  },
                  color: Colors.blue[900],
                  child: Text(
                    "take from gallery",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    getcam();
                  },
                  color: Colors.blue[900],
                  child: Text(
                    "take from camera",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getcam() async {
    var img = await image.getImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  getgall() async {
    var img = await image.getImage(source: ImageSource.gallery);

    if (img != null) {
      SaveData(img.path.toString());
      setState(() {
        file = File(img!.path);
      });
    }
  }

  var proimag = GetStorage();

  void SaveData(String val) async {
    proimag.write('imag', val);
    getData();
  }

  void getData() async {
    setState(() {
      ImagePath = proimag.read('imag');
    });
  }

}
