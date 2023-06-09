import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../button.dart';
import '../../attributes/colors.dart';
import '../../attributes/texts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// FirebaseFirestore _firestore = FirebaseFirestore.instance;
// FirebaseAuth _auth = FirebaseAuth.instance;
// User? _user = _auth.currentUser;

final _authentication = FirebaseAuth.instance;
User? loggedUser;
String? imageUrl;

Widget profileImage(String? imageUrl, VoidCallback changeProfileImage) {
  return Container(
    margin: EdgeInsets.only( top: 10,  bottom: 10),
    child: CircleAvatar(
      backgroundImage: imageUrl != null && imageUrl.isNotEmpty
          ? NetworkImage(imageUrl) as ImageProvider<Object>?
          : AssetImage('assets/images/gachi_logo.jpeg'),

      radius: 70,
    ),
  );
}

Widget nickName(String nick) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: Text(
      nick, // 닉네임
      style: AppTextStyles.nicknameTextStyle,
    ),
  );
}

Widget profileBox(BuildContext context, String nick, double temperD,
    String? imageUrl, VoidCallback changeProfileImage) {
  return Column(
    children: [
      Container(
        child: Column(
          children: [
            profileImage(imageUrl, changeProfileImage),
            nickName(nick),
          ],
        ),
      ),
      // Divider(
      //   thickness: 1,
      // ),
      profileOndo(context, temperD),
    ],
  );
}

Widget profileOndo(BuildContext context, double temperD) {
  double tempValue = temperD; // Change this based on your temperature value

  return Container(
    margin: EdgeInsets.only(top: 20),
    child: Column(
      children: [
        //Text('꽈배기 온도'),
        SizedBox(
          height: 30, // Change this for desired thickness
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: LinearProgressIndicator(
                value: tempValue,
                backgroundColor: Colors.white70,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              ),
            ),
          ),
        ),
        Text('꽈배기 온도 : $tempValue °C'), // Displaying temperature value
      ],
    ),
  );
}

Widget listBox(BuildContext context, String text, String route){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextButton(
        onPressed: () {
          // Do something when the button is pressed
          if(text == '로그아웃 ') {
            _authentication.signOut();
            try {
              final user = _authentication.currentUser;
              if(user != null) {

                loggedUser = user;
                print(loggedUser!.email);
              }
            } catch(e) {
              print(e);
            }
            print(loggedUser!.email);
            Navigator.pushNamed(context, route);
          }
        },
        child: Text(text,style: AppTextStyles.postSubTextStyle,),
      ),
    ],
  );
}

Widget profileBox2(BuildContext context, String route) {
  return Container(
    margin: EdgeInsets.only(top:20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(
          thickness: 0,
        ),

        listBox(context, '활동 뱃지', route),
        listBox(context,'개발자에게', route),
        listBox(context,'로그아웃 ', route),
      ],
    ),
  );
}

class ProfileModify extends StatelessWidget {
  const ProfileModify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}