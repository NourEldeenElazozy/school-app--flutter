import 'package:flutter/material.dart';
import 'package:students_mobile/HomeScreen/HomeScreen.dart';
import 'package:students_mobile/HomeScreen/HomeTeachersScreen.dart';
import 'package:students_mobile/Notification/notification_screen.dart';
import 'package:students_mobile/Teachers/AddPost.dart';
import 'package:students_mobile/Teachers/Test.dart';



import 'package:students_mobile/UI/calendar.dart';
import 'package:students_mobile/shared/components/components.dart';

class Teachersbar extends StatefulWidget {
  const Teachersbar({Key? key}) : super(key: key);

  @override
  State<Teachersbar> createState() => _TeachersbarState();
}

class _TeachersbarState extends State<Teachersbar> {
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
                HomeTeachersScreen(),
              );
            }
            if(index==1){
              currentIndex=1;
              navigateAndFinish(
                context,
                AddPostScreen(),
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
                AddtestScreen(),
              );
            }
          }




        },

        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
            backgroundColor: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'إضافة منشور',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_sharp),
            label: 'الحضور و الغياب',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            label: 'إضافة اختبار',
          ),

        ],
      ),


    );
  }
}
