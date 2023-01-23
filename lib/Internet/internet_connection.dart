import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:pixel_house/homepage.dart';

class InternetConnection extends StatefulWidget {
  const InternetConnection({Key? key}) : super(key: key);

  @override
  State<InternetConnection> createState() => _InternetConnectionState();
}

class _InternetConnectionState extends State<InternetConnection> {


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
  void initState() {
    super.initState();
    checkConnection();
  }



  Future checkConnection() async {
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => chooseScreen()));
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
    } else if (connectivityResult == ConnectivityResult.wifi) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => chooseScreen()));
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
    }else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => chooseScreen()));
    }
  }

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: ElevatedButton(
        //           onPressed: () async {
        //             var connectivityResult = await (Connectivity().checkConnectivity());
        //             if (connectivityResult == ConnectivityResult.none) {
        //               showDialog(
        //                   context: context,
        //                   builder: (BuildContext context) {
        //                     return AlertDialog(
        //                       title: Text("No internet connection"),
        //                       content: Text("Please check your internet connection and try again"),
        //                       actions: <Widget>[
        //                         ElevatedButton(
        //                           child: Text("Try Again"),
        //                           onPressed: () {
        //                             Navigator.of(context).pop();
        //                           },
        //                         ),
        //                       ],
        //                     );
        //                   });
        //             } else {
        //               Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        //             }
        //           },
        //           child: Text('Go to Login'),
        //         ),
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
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            ):TextButton(onPressed: ()async{

              if(isLoaded) return;
              setState((){
                isLoaded = true;
                checkConnection();
              });
              await Future.delayed(Duration(seconds: 3));
              setState(()=>isLoaded = false);

            },
                child: Text('Try Agine',
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
