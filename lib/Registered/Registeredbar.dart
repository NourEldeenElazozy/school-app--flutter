import 'package:flutter/material.dart';
import 'package:students_mobile/HomeScreen/HomeScreen.dart';
import 'package:students_mobile/HomeScreen/HomeTeachersScreen.dart';
import 'package:students_mobile/Notification/notification_screen.dart';
import 'package:students_mobile/Registered/reCalendar2.dart';
import 'package:students_mobile/Teachers/AddPost.dart';
import 'package:students_mobile/Registered/Attendance.dart';
import 'package:students_mobile/Teachers/Test.dart';



import 'package:students_mobile/UI/calendar.dart';
import 'package:students_mobile/shared/components/components.dart';

class Registeredbar extends StatefulWidget {
  const Registeredbar({Key? key}) : super(key: key);

  @override
  State<Registeredbar> createState() => _RegisteredbarState();
}

class _RegisteredbarState extends State<Registeredbar> {
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
                AttendanceScreen(),
              );
            }
            if(index==1){
              currentIndex=1;
              navigateAndFinish(
                context,
                AttendanceScreen(),
              );
            }


          }




        },

        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_rounded),
            label: 'تسجيل الحضور والغياب',
            backgroundColor: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.paste_sharp),
            label: 'كشف الحضور و الغياب',
          ),



        ],
      ),


    );
  }
}
