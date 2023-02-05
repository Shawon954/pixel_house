import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pixel_house/DataBase/database.dart';




class SinginPage extends StatefulWidget {
  const SinginPage({Key? key}) : super(key: key);

  @override
  State<SinginPage> createState() => _SinginPageState();
}

class _SinginPageState extends State<SinginPage> {
 final _formKey = GlobalKey<FormState>();

  bool pass = true;
  bool isLoaded = false;

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

    submithundel(){
      _formKey.currentState!.validate();
      _formKey.currentState!.save();
    }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  children: [
                Container(
                  height: Get.height / 4,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(80))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Sing in',
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
                            'My Pixel Store',
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
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(

                          controller: _emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white,fontSize: 20),
                          cursorColor: Colors.white,
                          cursorHeight: 25,
                          decoration: InputDecoration(

                              labelText: 'Em@il',
                              labelStyle: TextStyle(fontSize: 20,color: Colors.white),
                               prefixIcon:  Icon(Icons.email_outlined,color: Colors.white,),

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
                              return 'Your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height:20,
                        ),
                        TextFormField(
                          controller: _passwordcontroller,
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
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: ()=>Get.toNamed('/forgotpass'),
                      child: Text(
                        'Forget Password ? ',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'ProstoOne',
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
               isLoaded?Lottie.asset('assets/loadding/loading-animation.json',height: 100,width: 60): SizedBox(
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
                    child: Text('Login',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'ProstoOne',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: Colors.white),),
                    onPressed: ()async{
                         // Get.toNamed('/home_page');
                       var usersinginemail = _emailcontroller.text;
                       var Usersingpass = _passwordcontroller.text;

                       final obx = DataHelper();
                       obx.singIN(usersinginemail, Usersingpass,context);

                      submithundel();

                    },
                  ),
                ),
                    SizedBox(
                      height: 50,
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(text: TextSpan(text: "Don't have an account ? ",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'ProstoOne',
                          fontWeight: FontWeight.normal,
                          color: Colors.white),) ),
                    InkWell(
                      onTap: ()=>Get.toNamed('/sing_up'),
                      child: Text(
                        'Sing up ',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'ProstoOne',
                            fontWeight: FontWeight.normal,
                            color: Colors.amber),
                      ),
                    )
                  ],
                ),


              ]
              ),
            ),
        ),
    );
  }
}
