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
import 'package:pixel_house/details.dart';

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
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Are you sure to exit ?'),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (Platform.isAndroid) {
                              SystemNavigator.pop();
                            }
                          },
                          child: Text('Yes')),
                      VerticalDivider(),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No')),
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
    File imgfile = File(_userimage!.path);
    FirebaseStorage _storage = FirebaseStorage.instance;
    UploadTask uploadTask =
        _storage.ref('ProfileImage').child(_userimage!.name).putFile(imgfile);

    TaskSnapshot snapshot = await uploadTask;
    imageUrl = await snapshot.ref.getDownloadURL();
    print(imageUrl);

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

  bool isUploadImage = false;
  var selectImage;


  uploadProfileImage() async {
    var picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectImage = image.path;

      });

    }
    if (!mounted) return;
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
                  Container(
                    width: 128.0,
                    height: 128.0,
                    margin: EdgeInsets.only(
                      top: 24.0,
                      bottom: 64.0,
                    ),
                    child: CircleAvatar(
                      radius: 50,

                      child: ClipOval(
                        child: IconButton(
                            onPressed: () {
                              uploadProfileImage();
                              setState(() {
                                isUploadImage = true;

                              });
                            },
                            icon: Icon(Icons.add)),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${dataread.read('name')}',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'ProstoOne',
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Email: ${dataread.read('email')}',
                        style: TextStyle(
                            fontSize: 16,
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
                            fontSize: 16,
                            fontFamily: 'ProstoOne',
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ],
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
                    onTap: () => Get.toNamed('/profile_page'),
                    leading: Icon(Icons.home),
                    title: Text(
                      'profile',
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
            title: Text(
              'My Pixel ',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'ProstoOne',
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
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
                        print(data['URL'] + "     asdg");
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
                                    child: CircularProgressIndicator(
                                  strokeWidth: 4,
                                )),
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
}
