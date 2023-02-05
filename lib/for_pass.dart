import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForGetPassword extends StatefulWidget {
  const ForGetPassword({Key? key}) : super(key: key);

  @override
  State<ForGetPassword> createState() => _ForGetPasswordState();
}

class _ForGetPasswordState extends State<ForGetPassword> {



  bool isLoaded = false;

  final _formKey = GlobalKey<FormState>();

  singupsubmithundel(){
    _formKey.currentState!.validate();
    _formKey.currentState!.save();
  }

   TextEditingController _fotgetpass = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: [

            Align(
              alignment: Alignment.topLeft,
              child: IconButton(onPressed: ()=>Get.toNamed('/logingpage'),
                icon:Icon(Icons.arrow_back),color: Colors.white,),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Text(
                  'Forgot P@ssword',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'ProstoOne',
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 65, right: 65),
              child: Divider(
                thickness: 1.5,
                color: Colors.white,
                height: 1,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Your Em@il ',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'ProstoOne',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10,),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                          controller: _fotgetpass,
                      style: TextStyle(color: Colors.white,fontSize: 20),
                      cursorColor: Colors.white,
                      cursorHeight: 25,

                      decoration: InputDecoration(

                          labelText: 'Em@il',
                          labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                          focusedBorder: OutlineInputBorder(


                            borderSide:
                                const BorderSide(color: Colors.white, width: 2.0),
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
                  ),
                ],
              ),
            ),
              SizedBox(height: 100,),
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
                Text('RESET',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'ProstoOne',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.white),),
                onPressed: ()async{

                  if(isLoaded) return;
                  setState(()=>isLoaded = true);
                  await Future.delayed(Duration(seconds: 2),()=>Navigator.of(context));
                  setState(()=>isLoaded = false);

                  singupsubmithundel();
                  auth.sendPasswordResetEmail(email: _fotgetpass.text.toString()).then((value){
                   Get.snackbar('Reset Password', 'Check your email...');
                  })
                   .onError((error, stackTrace){
                     Get.snackbar('Worng', "Don't mass your password");
                  });

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
