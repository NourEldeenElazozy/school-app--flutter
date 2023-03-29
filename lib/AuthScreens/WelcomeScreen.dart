import 'package:students_mobile/AuthScreens/Login.dart';
import 'package:students_mobile/AuthScreens/LoginRegisteredScreen.dart';
import 'package:students_mobile/AuthScreens/LoginTeachersScreen.dart';

import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


import 'package:get/get.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/shared/components/components.dart';
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late String test;



  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,

          body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      child:  const Image(
                        image: AssetImage('assets/images/logo.png'),
                        height: 200.0,
                      ),
                    ),

                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Get.to(LoginTeachersScreen());
                        },
                        child: Padding(padding: EdgeInsets.all(20),
                          child:commonButton(null, 'Teacher'.tr,mainColor, ColorResources.whiteF6F) ,

                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: (){
                          Get.to(LoginScreen());
                        },
                        child: Padding(padding: EdgeInsets.all(20),
                          child:commonButton(null , 'Student'.tr, ColorResources.custom, ColorResources.whiteF6F) ,

                        ),
                      ),
                      Divider(height: 80),


                      TextButton(
                          onPressed: (){
                            Get.to(LoginRegisteredScreen());
                          },
                          child: mediumText('LogType'.tr, ColorResources.blue0C1, 18)),
                      Divider(height: Get.height/15),
                    mediumText('AppV'.tr, ColorResources.greyA0A, 14)

                    ],
                  )

                ],

              ),
            ),
          )

      ),
    );
  }
}
