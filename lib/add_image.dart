import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:pixel_house/DataBase/database.dart';


class ADDImage extends StatefulWidget {
  const ADDImage({Key? key}) : super(key: key);

  @override
  State<ADDImage> createState() => _ADDImageState();
}

class _ADDImageState extends State<ADDImage> {



 late CollectionReference imgRef;
  late firebase_storage.Reference ref;

  List<File> _uploadimage = [];
  String? imageUrl;
  ImagePicker _imagepicker = ImagePicker();
  ChooseImagegellary()async{

   final pickedFile = await _imagepicker.getImage(source: ImageSource.gallery,imageQuality: 75);

   setState(() {
     _uploadimage.add(File(pickedFile!.path));
   });
    if(pickedFile!.path == null) writeimage();
  }

  Future<void> writeimage()async{

    final LostData responce = await _imagepicker.getLostData();

    if(responce.isEmpty){
      return;
    }
  if(responce.file == null){
    setState(() {
      _uploadimage.add(File(responce.file!.path));
    });
  }
  else{
    print(responce.file);
  }

  }

  Future Uploadimage()async{
        int i =1;
    for(var img in _uploadimage){

       setState((){
         val = i/_uploadimage.length;
       });

      ref = firebase_storage.FirebaseStorage.instance.ref('UserImage/${path.basename(img.path)}');
      await ref.putFile(img).whenComplete(()async{

        await ref.getDownloadURL().then((value){
          imgRef.add({'URL':value});
        });
        i++;
      });

    }

  }




  @override
  void initState(){



    var _firestore = FirebaseFirestore.instance;
    imgRef =  _firestore.collection('UaerData')
        .doc(user!.email)
        .collection('ImageDataURL');


    super.initState();

  }



    User? user = FirebaseAuth.instance.currentUser;

  bool uploading = false;
  double val = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Add Image ',
            style: TextStyle(
                fontSize: 22,
                fontFamily: 'ProstoOne',
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
          centerTitle: true,

          actions: [
            TextButton(onPressed: (){
              setState(() {
                uploading = true;
              });

              Uploadimage().whenComplete(() => Navigator.of(context).pop());
            },
                child:  Text(
                  'Upload ',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'ProstoOne',
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),)
          ],
        ),


      body: Padding(
        padding: const EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 5),
        child: Stack(
          children: [
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 1.5,mainAxisSpacing: 1.5),
               itemCount:_uploadimage.length+1 ,
                itemBuilder: (_,index){
                  return index==0 ? Center(
                    child: IconButton(onPressed: ()=>ChooseImagegellary(),
                        icon: Icon(Icons.image,size: 26,color: Colors.lightGreen,)),
                  ):Container(
                    height: 80,
                    width: 80,
                   

                    decoration: BoxDecoration(
                        color: Colors.amber,
                        image: DecorationImage(image: FileImage(_uploadimage[index-1]))
                  ),
                  );
                }),
            uploading?Center(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      child: Text(
                        'Uploading... ',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'ProstoOne',
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  CircularProgressIndicator(
                    value: val,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  )

                ],
              ),
            ):Container(),

          ],

        ),

      ),


    );
  }
}
