import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  final currentUser = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(


      child: Scaffold(
          drawer: Drawer(
            key: _globalKey,
          ),

          appBar: AppBar(
  automaticallyImplyLeading: false,

),

          body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('UserInfoData')
            .where('id', isEqualTo: currentUser.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {

            return Text("Loading");
          }

          return ListView(

            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Text(data['email']),
              );
            }).toList(),
          );
        },
      )),
    );
  }
}
