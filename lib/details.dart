


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
class DETAILS extends StatelessWidget {
  DETAILS( this.imageLiknk);

  var imageLiknk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          'My Pixel ',
          style: TextStyle(
              fontSize: 22,
              fontFamily: 'ProstoOne',
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),

      ),
      body: Container(
        height: Get.height*2.9,
        width: double.infinity,
          color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 10),
          child: PhotoView(
            imageProvider: NetworkImage(imageLiknk),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 10,
            initialScale: PhotoViewComputedScale.contained * 1.1,
              basePosition: Alignment.center,
            enableRotation: true,

            backgroundDecoration: BoxDecoration(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

