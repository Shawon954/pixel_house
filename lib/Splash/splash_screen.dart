
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final box = GetStorage();

  chooseScreen()async{
    var UserID =await box.read('LOGING');
    if(UserID!= null){
    return Get.offAndToNamed('/home_page');
    }
    else{
     return  Get.offAndToNamed('/logingpage');
    }
  }


  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),()=>chooseScreen());
    return Scaffold(
      body: Center(
        child: Image.asset('assets/splash_image.png',height:300,width: 300,),
      ),
    );
  }
}
