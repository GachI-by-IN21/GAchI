import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../attributes/colors.dart';
/*
*   버튼관리 코드
*   route는 main에서 관리함.
*   ex )
* TextButton(
        onPressed: () {
          Navigator.pushNamed(context, route);        // route -> main.dart
          if (onPressed != null) {
            onPressed();
          }
        },
* */

Widget button(String text, {VoidCallback? onPressed}) {
  return Align(
    alignment: Alignment.center,
    child: Container(
        margin: const EdgeInsets.all(5),
        width: 240,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.sub2Color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            primary: Colors.white, // This sets the text color
          ),
          child: Center(child: Text(text)),
        )),
  );
}

Widget pinButton(BuildContext context, String text, String route,
    {VoidCallback? onPressed}) {
  return Align(
    alignment: Alignment.center,
    child: Container(
      margin: const EdgeInsets.all(5),
      width: 250,
      height: 50,
      decoration: BoxDecoration(
          color: AppColors.sub2Color, borderRadius: BorderRadius.circular(25)),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
          if (onPressed != null) {
            onPressed();
          }
        },
        style: TextButton.styleFrom(
          primary: Colors.white, // This sets the text color
        ),
        child: Center(child: Text(text)),
      ),
    ),
  );
}

// 모집자 메인 화면 '가치만들기 button'
Widget gachiMakeButton(BuildContext context, String text, String route,
    {VoidCallback? onPressed}) {
  return Align(
    alignment: Alignment.center,
    child: Container(
        margin: const EdgeInsets.all(5),
        width: 250,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.sub2Color,
            borderRadius: BorderRadius.circular(25)),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
            if (onPressed != null) {
              onPressed();
            }
          },
          style: TextButton.styleFrom(
            primary: Colors.white, // This sets the text color
          ),
          child: Center(child: Text(text)),
        )),
  );
}

Widget categoriesButtons(BuildContext context,
    {Function(String)? onRadioButtonChanged}) {
  return CustomRadioButton(
    margin: EdgeInsets.all(0),
    elevation: 1.0,
    absoluteZeroSpacing: false,
    horizontal: true,
    height: 60,
    unSelectedColor: Theme.of(context).canvasColor,
    buttonLables: ['스터디', '밥', '공모전', '팀플', '담배', '대외활동', '기타'],
    buttonValues: ['스터디', '밥', '공모전', '팀플', '담배', '대외활동', '기타'],
    unSelectedBorderColor: Colors.green,
    selectedBorderColor: Colors.lightGreen,
    buttonTextStyle: ButtonTextStyle(
      selectedColor: Colors.white,
      unSelectedColor: Colors.black,
      textStyle: TextStyle(fontSize: 16),
    ),
    radioButtonValue: (categori) {
      onRadioButtonChanged?.call(categori);  // 변경점: 카테고리 변경 콜백 호출
    },
    selectedColor: AppColors.mainColor,
  );
}

Widget registerbutton(BuildContext context, String text, String route,
    {VoidCallback? onPressed}) {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  return Align(
    alignment: Alignment.center,
    child: Container(
        margin: const EdgeInsets.all(10),
        width: 210,
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.sub2Color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextButton(
          onPressed: () {
            try {
              Navigator.pushNamed(context, route);
              if (onPressed != null) {
                onPressed();
              }
            } catch (e) {
              print('Error: $e');
            }
          },
          style: TextButton.styleFrom(
            primary: Colors.white, // This sets the text color
          ),
          child: Center(
              child: Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
        )),
  );
}

/*               프로필 버튼 페이지  */
Widget profileModify_button(BuildContext context, Future Function() _changeProfileImage, String text, String route, {VoidCallback? onPressed}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double buttonWidth = screenWidth * 0.20; // 버튼 넓이
  return Align(
    alignment: Alignment.center,
    child: Container(
      margin: const EdgeInsets.only(right: 10),
      width: buttonWidth,
      height: 35,
      decoration: BoxDecoration(
        color: AppColors.sub2Color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () {
          _changeProfileImage();
        },
        style: TextButton.styleFrom(
          primary: Colors.white, // This sets the text color
        ),
        child: Center(child: Text(text)),
      ),
    ),
  );
}


/*    가치 삭제버튼  */
Widget gachiDelete_button(BuildContext context, String text, {VoidCallback? onPressed}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double buttonWidth = screenWidth * 0.20; // 버튼 넓이
  return Align(
    alignment: Alignment.center,
    child: Container(
      margin: const EdgeInsets.only(right: 10),
      width: buttonWidth,
      height: 35,
      decoration: BoxDecoration(
        color: AppColors.sub2Color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () {
          if(text == '신고하기') {
            // 유저 신고하기  (아직 기능페이지 안 만듦)   -- 지원자만 가능
          } else if(text == '가치 삭제') {
            // 가치 삭제하기 기능 -- 모집자 만 가능
          }
          if (onPressed != null) {
            onPressed();
          }
        },
        style: TextButton.styleFrom(
          primary: Colors.white, // This sets the text color
        ),
        child: Center(child: Text(text)),
      ),
    ),
  );
}



Widget loginbutton(BuildContext context, String text, String route,
    String username, String password,
    {VoidCallback? onPressed}) {
  final _authentication = FirebaseAuth.instance;
  return Align(
    alignment: Alignment.center,
    child: Container(
        margin: const EdgeInsets.all(10),
        width: 210,
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.sub2Color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextButton(
          onPressed: () async {
            int id_pw = 0;
            QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('Users').get();
            List<QueryDocumentSnapshot> userDocuments = usersSnapshot.docs;

            for (QueryDocumentSnapshot document in userDocuments) {
              if (document['id'] == username) {
                id_pw += 1;
                if (document['pw'] == password) {
                  id_pw += 1;
                  try {
                    final newUser = await _authentication
                        .signInWithEmailAndPassword(
                      email: username,
                      password: password,
                    );
                    if (newUser.user != null) {
                      Navigator.pushNamed(context, route);
                        }
                    } catch (e) {
                    print(e);
                  }
                }
              }
            }
            if (id_pw == 0){
              print("올바르지 않은 id 입니다.");
            }
            else if (id_pw == 1) {
              print('비밀번호가 올바르지 않습니다');
            }
            // Navigator.pushNamed(context, route);
            if (onPressed != null) {
              onPressed();
            }
            // Navigator.pushNamed(context, route);
          },
          style: TextButton.styleFrom(
            primary: Colors.white, // This sets the text color
          ),
          child: Center(
              child: Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
        )),
  );
}
