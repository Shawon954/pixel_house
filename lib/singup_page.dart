
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pixel_house/DataBase/database.dart';



class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _formKey = GlobalKey<FormState>();

  bool isLoaded = false;
  bool pass = true;


  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _phone = TextEditingController();

  final boxx = GetStorage();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Container(
              height: Get.height / 4,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.shade200,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(180),
                    bottomRight: Radius.circular(180)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Center(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () => Get.toNamed('/logingpage'),
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'ProstoOne',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'My Pixel Store Account',
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'ProstoOne',
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _name,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      cursorColor: Colors.white,
                      cursorHeight: 25,
                      decoration: InputDecoration(
                          prefixIcon:  Icon(Icons.person,color: Colors.white,),
                          labelText: 'N@me',
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.white),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10.5),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.5),
                              borderSide: BorderSide(width: 1.5)),
                          fillColor: Colors.grey,
                          focusColor: Colors.grey),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Your N@me';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      cursorColor: Colors.white,
                      cursorHeight: 25,

                      decoration: InputDecoration(
                          prefixIcon:  Icon(Icons.email_outlined,color: Colors.white,),
                          labelText: 'Em@il',
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.white),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10.5),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.5),
                              borderSide: BorderSide(width: 1.5)),
                          fillColor: Colors.grey,
                          focusColor: Colors.grey),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _password,
                      keyboardType: TextInputType.text,
                      obscureText: pass,
                      style: TextStyle(color: Colors.white,fontSize: 20),
                      cursorColor: Colors.white,
                      cursorHeight: 25,
                      decoration: InputDecoration(

                          labelText: 'P@ssword',

                          prefixIcon:  Icon(Icons.lock_open_outlined,color: Colors.white,),
                          suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                pass = !pass;
                              });
                            },
                            child: Icon(pass? Icons.visibility_off_outlined:Icons.visibility_outlined,color: Colors.white,),
                          ),
                          labelStyle: TextStyle(fontSize: 20,color: Colors.white),
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10.5),
                          ),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.5),
                              borderSide: BorderSide(
                                  width: 1.5
                              )
                          ),
                          fillColor: Colors.grey, focusColor: Colors.grey),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Your Password';
                        }
                        return null;
                      },
                    ),
                    // TextFormField(
                    //   controller: _password,
                    //   style: TextStyle(color: Colors.white, fontSize: 20),
                    //   cursorColor: Colors.white,
                    //   cursorHeight: 25,
                    //   decoration: InputDecoration(
                    //       labelText: 'P@ssword',
                    //       labelStyle:
                    //           TextStyle(fontSize: 20, color: Colors.white),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: const BorderSide(
                    //             color: Colors.white, width: 2.0),
                    //         borderRadius: BorderRadius.circular(10.5),
                    //       ),
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10.5),
                    //           borderSide: BorderSide(width: 1.5)),
                    //       fillColor: Colors.grey,
                    //       focusColor: Colors.grey),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Your P@ssword';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _phone,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      cursorColor: Colors.white,
                      cursorHeight: 25,
                      decoration: InputDecoration(
                          prefixIcon:  Icon(Icons.phone,color: Colors.white,),
                          labelText: 'Phone',
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10.5),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.5),
                              borderSide: BorderSide(width: 1.5)),
                          fillColor: Colors.grey,
                          focusColor: Colors.grey),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Your Phone';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            
            SizedBox(
              height: Get.height/18,
              width: Get.width/1.8,
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
                child: isLoaded ?
                Row(
                  children: [

                    CircularProgressIndicator(

                      color: Colors.white,
                    ),
                    SizedBox(width: 8,),
                    Text('Places Wait',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'ProstoOne',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: Colors.white),)
                  ],
                ):
                Text('REGISTER',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'ProstoOne',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.white),),
                onPressed: ()async{

                  // if(isLoaded) return;
                  // setState(()=>isLoaded = true);
                  // await Future.delayed(Duration(seconds: 3));
                  // setState(()=>isLoaded = false);

                   if(_formKey.currentState!.validate()){

                     var singupname = _name.text.trim();
                     var upemail = _email.text.trim();
                     var uppass = _password.text.trim();
                     var  singupphone = _phone.text.trim();

                     final userinput = DataHelper();
                     userinput.singUP(upemail, uppass,context,singupname,singupphone,);
                       _formKey.currentState!.save();

                       boxx.write('name', singupname,);
                       boxx.write('email', upemail,);
                       boxx.write('phone',singupphone);

                   }



                },
              ),
            ),
            SizedBox(
              height: 20,
            ),

            
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(
                  text: "Already have an account ? ",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'ProstoOne',
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                )),
                InkWell(
                  onTap: () => Get.toNamed('/logingpage'),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'ProstoOne',
                        fontWeight: FontWeight.normal,
                        color: Colors.amber),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ]),
        ),
      ),
    );
  }
}
