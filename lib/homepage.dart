import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:pixel_house/details.dart';
import 'package:pixel_house/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _advancedDrawerController = AdvancedDrawerController();

  exidDilog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Are you sure to exit ?',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'ProstoOne',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Colors.grey),),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height/20,
                        width: Get.width/3.8,
                        child: ElevatedButton(

                          style:ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,

                              foregroundColor: Colors.deepPurpleAccent,
                              elevation: 3.0,
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 1.2
                              )
                          ),
                          child: Text('Yes',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'ProstoOne',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                color: Colors.white),),
                          onPressed: (){
                            if (Platform.isAndroid) {
                              SystemNavigator.pop();
                            }
                          },
                        ),
                      ),
                      VerticalDivider(),
                      SizedBox(
                        height: Get.height/20,
                        width: Get.width/3.8,
                        child: ElevatedButton(

                          style:ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,

                              foregroundColor: Colors.deepPurpleAccent,
                              elevation: 3.0,
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 1.2
                              )
                          ),
                          child: Text('No',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'ProstoOne',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                color: Colors.white),),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ),




                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  var dataread = GetStorage();

  XFile? _userimage;
  String? imageUrl;

  var selectimage;
  choosegallery() async {
    final ImagePicker _picker = ImagePicker();
    _userimage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectimage = _userimage!.path;
    });
    File? imgfile = File(_userimage!.path);
    FirebaseStorage _storage = FirebaseStorage.instance;
    UploadTask uploadTask =
        _storage.ref('ProfileImage').child(_userimage!.name).putFile(imgfile);

    TaskSnapshot snapshot = await uploadTask;
    imageUrl = await snapshot.ref.getDownloadURL();
    print(imageUrl);
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference reference = FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(user!.email)
        .collection('imagelink');

    await reference.add({'imga': imageUrl});
  }

  User? user = FirebaseAuth.instance.currentUser;
  late final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('UaerData')
      .doc(user!.email)
      .collection('ImageDataURL')
      .snapshots();

  Future<void> DeleteImage(selectdocument) {
    return FirebaseFirestore.instance
        .collection('UaerData')
        .doc(user!.email)
        .collection("ImageDataURL")
        .doc(selectdocument)
        .delete()
        .then((value) => print('Delete'))
        .catchError((error) => print(error));
  }

  var boxxx = GetStorage();

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
    return WillPopScope(
      onWillPop: () {
        exidDilog(context);
        return Future.value(false);
      },
      child: AdvancedDrawer(
        backdropColor: Colors.blueGrey,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        drawer: SafeArea(
          child: Container(
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        SizedBox(height: 100,),
                        Stack(
                          children:<Widget> [
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
                        SizedBox(
                          height: 10,),

                        Text(
                          'Name: ${dataread.read('name')}',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'ProstoOne',
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Email:${dataread.read('email')}',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'ProstoOne',
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Phone: ${dataread.read('phone')}',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'ProstoOne',
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () => Get.toNamed('/home_page'),
                    leading: Icon(Icons.home),
                    title: Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'ProstoOne',
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),


                  ListTile(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAndToNamed('/logingpage');
                    },
                    leading: Icon(Icons.logout),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'ProstoOne',
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: Text('Terms of Service | Privacy Policy'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueGrey,
            centerTitle: true,
            title: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
              },
              child: Text(
                'My Pixel ',
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'ProstoOne',
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/somthingworng/sad'),
                    SizedBox(height: 10,),
                    Text('Something went wrong',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'ProstoOne',
                          fontWeight: FontWeight.normal,
                          color: Colors.white),),
                  ],
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [
                    Lottie.asset('assets/loadding/loading-animation.json',height: 100,width: 60),
                    SizedBox(height: 10,),
                    Text('Loading',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'ProstoOne',
                          fontWeight: FontWeight.normal,
                          color: Colors.white),),
                  ],
                );
              }

              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  return Padding(
                    padding:
                        EdgeInsets.only(top: 5, right: 5, left: 5, bottom: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DETAILS(data["URL"])));
                      },
                      child: Card(
                        elevation: 8,
                        child: Stack(
                          children: [
                            Hero(
                              tag: 'img',
                              child: CachedNetworkImage(
                                height: double.infinity,
                                width: double.infinity,
                                imageUrl: data['URL'],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Center(
                                //     child: CircularProgressIndicator(
                                //   strokeWidth: 4,
                                // )),
                                     child:  Lottie.asset('assets/loadding/loading-animation.json',height: 100,width: 60),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Positioned(
                              right: 0.0,
                              child: Container(
                                height: 30,
                                width: 30,
                                child: IconButton(
                                    onPressed: () {
                                      DeleteImage(document.id);
                                      Get.snackbar(
                                          'Image', 'Delete Sucessfull');
                                    },
                                    icon: Icon(
                                      Icons.delete_forever,
                                      size: 25,
                                      color: Colors.pinkAccent,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.toNamed('/addImages_page'),
            child: Icon(Icons.image),
          ),
        ),
      ),
    );
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
