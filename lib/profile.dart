import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class Profile extends StatefulWidget {
   Profile(this.readimage);

  var readimage;

  @override
  State<Profile> createState() => _ProfileState(readimage);
}

class _ProfileState extends State<Profile> {
  var readimage;

    _ProfileState(this.readimage);

    var proimag = GetStorage();
    var pro = GetStorage();


  XFile? _userimage;
  String? imageUrl;

  choosegallery()async{
    final ImagePicker _picker = ImagePicker();
    _userimage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = _userimage!.path;
    });
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
    body:  Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        Center(
          child: Container(
              height: Get.height/5.5,
              width: Get.width/2.5,
              color: Colors.deepPurple,

              child: _userimage == null ?IconButton(
                icon: Icon(Icons.photo,color: Colors.white,), onPressed: (){
                   proimag.write('img', _userimage);
                  choosegallery();
                     ambiguate(_userimage);
                }
              ):Image.file(File(_userimage!.path),
                fit: BoxFit.fill,
                width: 200,
              )
          ),
        ),
SizedBox(height: 50,),


          Container(
            child:  PhotoView(
              imageProvider: NetworkImage(readimage),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 10,
              initialScale: PhotoViewComputedScale.contained * 1.1,
              basePosition: Alignment.center,
              enableRotation: true,

              backgroundDecoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),
          )

      ],
    ),

    );
  }
}
