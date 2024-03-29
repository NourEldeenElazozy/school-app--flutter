import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_mobile/HomeScreen/HomeScreen.dart';
import 'package:students_mobile/Notification/notification_screen.dart';
import 'package:students_mobile/Profile/Profile.dart';



import 'package:students_mobile/UI/calendar.dart';
import 'package:students_mobile/shared/components/components.dart';

class bar extends StatefulWidget {
  const bar({Key? key}) : super(key: key);

  @override
  State<bar> createState() => _barState();
}

class _barState extends State<bar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        fixedColor:  mainColor,
        onTap: (index) {

          if(index!=currentIndex){
            if(index==0){
              currentIndex=0;
              navigateAndFinish(
                context,
                HomeScreen(),
              );
            }
            if(index==1){
              currentIndex=1;
              navigateAndFinish(
                context,
                TableEventsExample(),
              );
            }
            if(index==2){
              currentIndex=2;
              navigateAndFinish(
                context,
                NotificationScreen(),
              );
            }
            if(index==3){
              currentIndex=3;
              navigateAndFinish(
                context,
                Profile(),
              );
            }
          }




        },

        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'.tr,
            backgroundColor: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_sharp),
            label: 'Calendar'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Notification'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'.tr,
          ),

        ],
      ),


    );
  }
}
