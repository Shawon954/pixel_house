
import 'package:get/get.dart';
import 'package:pixel_house/Internet/internet_connection.dart';
import 'package:pixel_house/Splash/splash_screen.dart';
import 'package:pixel_house/add_image.dart';
import 'package:pixel_house/for_pass.dart';
import 'package:pixel_house/homepage.dart';
import 'package:pixel_house/profile.dart';
import 'package:pixel_house/setting.dart';
import 'package:pixel_house/singin_page.dart';
import 'package:pixel_house/singup_page.dart';

List<GetPage>getpage=[
  GetPage(name: '/splash', page: ()=>SplashScreen()),
  GetPage(name: '/internetcheck', page: ()=>InternetConnection()),
  GetPage(name: '/logingpage', page: ()=>SinginPage()),
  GetPage(name: '/sing_up', page: ()=>SingUpPage()),
  GetPage(name: '/forgotpass', page: ()=>ForGetPassword()),
  GetPage(name: '/home_page', page: ()=>HomePage()),
  GetPage(name: '/addImages_page', page: ()=>ADDImage()),







];


   // Profile Code //
// File? file;
// ImagePicker image = ImagePicker();
// String? ImagePath;
//
// @override
// void initState() {
//   getData();
//   super.initState();
// }
  // profile code //