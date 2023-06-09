import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:provider/provider.dart';
import 'package:gachi/pages/userAdd/gachiForm.dart';
import '../components/forms/userAddForm.dart';
import 'bottomMenuPage/recruiterMainPage.dart';
import '../components/forms/makeGachiForm.dart';
import 'package:intl/intl.dart';

/*    <모집자 페이지>
      가치만들기(생성)  메인 코드
*       1. 첫번째 화면 : Select_Datail(화면)
*       2. 두번째 화면 :  Select_Category(화면), buildSlider(위젯)
*       3. 세번째 화면 : Last_Step(화면)

        주요코드
      pageBodies: [
        Select_Category(),
        SafeArea(child: Select_Detail(),),
        SafeArea(child :Last_Step(), ),
      ],

      background Image가 필요없어도 안 넣으면 패키지 특성상, 오류남.
      그래서 height 0으로 설정(보이지 않기위해)
*
* */
void _showMakeGachi(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // User must tap button to close dialog
    builder: (BuildContext context) {
      return Dialog(
        child: MakeGachi(),
      );
    },
  );
}

const kDarkBlueColor = Color(0xFF053149);
const kBackgroundImagePath = 'assets/images/dog2.png';
const kTotalPages = 3;
const kPageBackgroundColor = Colors.white;
const kHeaderBackgroundColor = Colors.white;
const kControllerColor = kDarkBlueColor;

class MakeGachi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: '가치만들기',
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: Colors.green,
      ),
      onFinish: () => _navigateToRecruitPage(context),
      background: List.filled(kTotalPages, Image.asset(kBackgroundImagePath, height: 0)),
      controllerColor: kControllerColor,
      totalPage: kTotalPages,
      headerBackgroundColor: kHeaderBackgroundColor,
      pageBackgroundColor: kPageBackgroundColor,
      speed: 1.8,
      pageBodies: [
        SafeAreaChild(Select_Category()),
        SafeAreaChild(Select_Detail()),
        SafeAreaChild(Last_Step()),
      ],
    );
  }

  void _navigateToRecruitPage(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime koreaTime = now.toUtc().add(const Duration(hours: 9)); // 한국 시간은 UTC 시간에 9시간을 더한 값입니다

    String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(koreaTime); // 형식화된 시간 문자열 생성
    // print(formattedTime); // 형식화된 시간 문자열 출력
    FormData formData = Provider.of<FormData>(context, listen: false);
    final _authentication = FirebaseAuth.instance;
    User? loggedUser;
    print('Recruit');
    print(formData.title);
    print(formData.category);
    print(formData.body);
    print(formData.genders);
    print(formData.selectedGender);
    print(formData.sliderValue1);
    print(formData.sliderValue2);
    int group = formData.sliderValue1.toInt();
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.uid);
        print((loggedUser!.uid).runtimeType);
      }
    } catch (e) {
      print(e);
    }
    // String nick = '';
    String uid = loggedUser!.uid;
    DocumentReference userDocRef =
    FirebaseFirestore.instance.collection('Users').doc(loggedUser!.uid);
    userDocRef.get().then((docSnapshot) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        // final String nick = data['nick'];
        // print(nick);
        CollectionReference postsCollection = FirebaseFirestore.instance.collection('Posts');

        DocumentReference newDocRef = postsCollection.doc(); // 새로운 문서 생성

        String newDocId = newDocRef.id; // 새로운 문서의 uid 얻기

// 생성한 문서에 데이터 설정
      newDocRef.set({
        'category': formData.category,
        'gender': formData.selectedGender,
        'group': group,
        'text': formData.body,
        'title': formData.title,
        'uid': loggedUser!.uid,
        'puid': newDocId,
        'nick': data['nick'],
        'date': formattedTime
      });
    });
    // FirebaseFirestore.instance.collection('Users').doc(uid).get().then((docSnapshot) {
    //   if (docSnapshot.exists) {
    //     Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    //     nick = data['nick'];
    //   } else {
    //     print('No user nick');
    //   }
    // }).catchError((error) {
      // 오류 처리
    // });
//     CollectionReference postsCollection = FirebaseFirestore.instance.collection('Posts');
//
//     DocumentReference newDocRef = postsCollection.doc(); // 새로운 문서 생성
//
//     String newDocId = newDocRef.id; // 새로운 문서의 uid 얻기
//
// // 생성한 문서에 데이터 설정
//     newDocRef.set({
//       'category': formData.category,
//       'gender': formData.selectedGender,
//       'group': group,
//       'text': formData.body,
//       'title': formData.title,
//       'uid': loggedUser!.uid,
//       'puid': newDocId,
//       'nick': nick,
//       'date': formattedTime
//     });
    // DocumentReference userDocRef =
    // FirebaseFirestore.instance.collection('Users').doc(loggedUser!.uid);
    // checkFormData(formData);
    // formdata를 파이어베이스에 보내면 됩니다!
    Navigator.of(context, rootNavigator: true).pop();
  }
}

class SafeAreaChild extends StatelessWidget {
  final Widget child;

  const SafeAreaChild(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: child);
  }
}
