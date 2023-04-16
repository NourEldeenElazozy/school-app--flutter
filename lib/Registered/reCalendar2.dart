import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:students_mobile/Utiils/User.dart';
import 'package:students_mobile/Utiils/text_font_family.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



/// The app which hosts the home page which contains the calendar on it.


/// The hove page which hosts the calendar
class reCalendarApp extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const reCalendarApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _reCalendarAppState createState() => _reCalendarAppState();
}

class _reCalendarAppState extends State<reCalendarApp> {
  final List<Meeting> meetings = <Meeting>[];
  Future<List<Meeting>> _getDataSource()  async {


     await FirebaseFirestore.instance
        .collection('Attendance')
        //.where("student_name", isEqualTo: User.studentName)
        .get()
        .then(
          (value) {
            meetings.clear();
        value.docs.forEach(
              (result) {

            //if (meetings.length < value.docs.length) {


               String absence;
               int color=0xFF0F8644;
      if( result['absence']==true){
        absence='حضور';

       }else{
        color=0xFF860F1D;

        absence='غياب';
      }

              meetings.add(

                Meeting(

                    absence,
                    DateTime.parse( result['ddate']),
                    DateTime.parse(result['ddate']),
                     Color(color),
                    false),
              );

           // }


          },
        );
      },
    );
    return meetings;
  }

  @override
  Widget build(BuildContext context) {

    _getDataSource();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: FutureBuilder(
            future:  _getDataSource(),
            builder: (context, snapshot) {
            if (snapshot.hasData) {
              return     SfCalendar(
                viewHeaderStyle: ViewHeaderStyle(backgroundColor: Colors.cyan),
                 headerStyle: CalendarHeaderStyle(textAlign: TextAlign.center,textStyle: TextStyle(fontFamily: TextFontFamily.KHALED_FONT,fontSize: 18)),

                cellEndPadding: 2.0,



                todayHighlightColor: Colors.blue,
                cellBorderColor: Colors.blue,
                appointmentTextStyle: TextStyle(fontSize: 25,fontFamily: TextFontFamily.KHALED_FONT,fontWeight: FontWeight.bold,),
                view: CalendarView.month,
                dataSource: MeetingDataSource(meetings),
                // by default the month appointment display mode set as Indicator, we can
                // change the display mode as appointment using the appointment display
                // mode property
                monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
            },

          )),
    );
  }


}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}