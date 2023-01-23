
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class Profile extends StatelessWidget {


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbcb3be),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blueGrey,
        title: Text(
          'About',
          style: TextStyle(
              fontSize: 22,
              fontFamily: 'ProstoOne',
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

             Padding(
               padding: const EdgeInsets.only(left: 15,right: 15),
               child: Card(
                 elevation: 10,
                 color: Colors.white,

                 child: Column(
                   children: [
                     SizedBox(height: 20,),
                     Center(
                       child: CircleAvatar(
                         radius: 60,
                           backgroundImage: AssetImage('assets/about/mee.png'),
                       ),
                     ),
                     SizedBox(height: 15,),
                     Text('Md.Abdur Rahman (Shawon)',
                       style: TextStyle(
                           fontSize: 18,
                           fontFamily: 'ProstoOne',
                           fontWeight: FontWeight.normal,
                           color: Colors.grey),),
                     SizedBox(height: 5,),
                     Text('Bsc in Computer Science Engineering',
                       style: TextStyle(
                           fontSize: 16,
                           fontFamily: 'ProstoOne',
                           fontWeight: FontWeight.normal,
                           color: Colors.grey),),
                     SizedBox(height: 5,),
                     Text('Daffodil Institute of IT',
                       style: TextStyle(
                           fontSize: 16,
                           fontFamily: 'ProstoOne',
                           fontWeight: FontWeight.normal,
                           color: Colors.grey),),
                     SizedBox(height: 20,),


                   ],
                 ),
               ),
             ),


        ],
      ),
    );
  }



}
