


import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
class DETAILS extends StatelessWidget {
  DETAILS( this.imageLiknk);

  var imageLiknk;




  imagedownload()async{
  if(imageLiknk != null){
    GallerySaver.saveImage(imageLiknk,albumName: '');
    Get.snackbar('Image', 'Download Successfully');
  }
     else{
       return 'Failed';
  }
  }

 imageshare()async{
    await Share.share(imageLiknk);
  }

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
          child: Stack(
            children:[ 
              PhotoView(
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

              Positioned(
                bottom: 100,
                  right: 10,
                  child: Column(
                    children: [
                      InkWell(
                            onTap: (){
                              imageshare();
                            },
                        child: Lottie.asset('assets/share/share-icon.json',height: 30,width: 30,),
                      ),
                      InkWell(
                            onTap: (){
                              imagedownload();
                            },
                        child: Lottie.asset('assets/down_icon/download-icon.json',height: 60,width: 60),
                      ),
                    ],
                  ),
              ),
           ]
          ),
        ),
      ),
    );
  }
}

