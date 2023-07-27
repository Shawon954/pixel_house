import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:pixel_house/homepage.dart';

class InternetConnection extends StatefulWidget {
  const InternetConnection({Key? key}) : super(key: key);

  @override
  State<InternetConnection> createState() => _InternetConnectionState();
}

class _InternetConnectionState extends State<InternetConnection> {




  final box = GetStorage();

  // chooseScreen()async{
  //   var UserID =await box.read('LOGING');
  //   if(UserID!= null){
  //     return Get.off('/home_page');
  //   }
  //   else{
  //     return  Get.off('/logingpage');
  //   }
  // }




  @override
  void initState() {
    super.initState();
    checkConnection();
  }
  User? user = FirebaseAuth.instance.currentUser;



  checkConnection() async {

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        webShowClose: true,
        webBgColor: "red",
        webPosition: "bottom",
      );

    }
    else if (connectivityResult == ConnectivityResult.mobile) {
      print("Mobile internet");
      Fluttertoast.showToast(
        msg: "Mobile internet",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        webShowClose: true,
        webBgColor: "red",
        webPosition: "bottom",
      );

      if(user == null){
        Get.offAndToNamed('/logingpage');
      }
      else {
        Get.offAndToNamed('/home_page');
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("WiFi");
      Fluttertoast.showToast(
        msg: "WiFi",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        webShowClose: true,
        webBgColor: "red",
        webPosition: "bottom",
      );
      if(user == null){
        Get.offAndToNamed('/logingpage');

      }
      else {
        Get.offAndToNamed('/home_page');
      }    }
  }

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/internet/no-internet.json',height: 100,width: 100),
            SizedBox(
              height: 10,
            ),

            Text(
              'Something went wrong!',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'ProstoOne',
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),

            ),  SizedBox(
              height: 5,
            ),

            Text(
              'Please turn on your internet connection',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'ProstoOne',
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),

            ),
            const SizedBox(
              height: 15,
            ),

            isLoaded?
            SizedBox(
              height: 60,
              width: 50,
              child: Lottie.asset('assets/loadding/loading-animation.json',height: 100,width: 60,),
            ):TextButton(onPressed: ()async{

              if(isLoaded) return;
              setState((){
                isLoaded = true;
                checkConnection();

              });
              await Future.delayed(Duration(seconds: 3));
              setState(()=>isLoaded = false);

            },
              child: Text('Try Again',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'ProstoOne',
                    fontWeight: FontWeight.normal,
                    color: Colors.white),),style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                backgroundColor: Colors.grey,
              ),
            )

          ],
        ),
      ),
    );
  }
}

