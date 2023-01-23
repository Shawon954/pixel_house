
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pixel_house/Internet/internet_connection.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final boxx = GetStorage();

  chooseScreen()async{
    var UserID =await boxx.read('LOGING');
    if(UserID!= null){
    return Get.offAndToNamed('/home_page');
    }
    else{
     return  Get.offAndToNamed('/logingpage');
    }
  }

 
   SelectPage()async{
     var connectivityResult = await (Connectivity().checkConnectivity());
     if(connectivityResult == ConnectivityResult.none){

       Navigator.push(context, MaterialPageRoute(builder: (context) => InternetConnection()));

     }else{
       Navigator.push(context, MaterialPageRoute(builder: (context) =>chooseScreen()));
     }
   }


  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 3),()=>chooseScreen());
    Future.delayed(Duration(seconds: 3),()=>SelectPage());
    return Scaffold(
      body: Center(
        child: Image.asset('assets/splash_image.png',height:300,width: 300,),
      ),
    );
  }
}
