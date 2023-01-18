import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pixel_house/homepage.dart';



class DataHelper {


  var Box = GetStorage();

  Future singUP( email, password, context, String singupname, String singupphone,)async{

    FirebaseAuth _auth = FirebaseAuth.instance;

        try {
      UserCredential credential = await _auth. createUserWithEmailAndPassword(email: email, password: password,);

      var authCredential = credential.user;
      var nano = authCredential;

      if(nano!.uid.isNotEmpty){
          Box.write('LOGING', nano.uid);
           Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

           Fluttertoast.showToast(

               msg: 'Singup Successful'

           );





      }else{
        return 'singup filed';
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }



  Future singIN(email, password, context) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var authCredential = credential.user;
      if (authCredential!.uid.isNotEmpty) {
        Box.write('LOGING', authCredential.uid);
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        return "sing in failed";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}


