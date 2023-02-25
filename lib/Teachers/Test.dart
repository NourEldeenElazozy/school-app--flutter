// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0
import 'package:intl/intl.dart' as aa;

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:students_mobile/HomeScreen/HomeTeachersScreen.dart';
import 'package:students_mobile/UI/Teachersbar.dart';
import 'package:students_mobile/UI/minu.dart';
import 'package:students_mobile/Utiils/User.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:students_mobile/Utiils/text_font_family.dart';
import 'package:students_mobile/shared/components/components.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

class AddtestScreen extends StatefulWidget {
  const AddtestScreen({super.key});

  @override
  _AddtestScreenState createState() => _AddtestScreenState();
}

class _AddtestScreenState extends State<AddtestScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final TextEditingController contentController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
   final TextEditingController dateController = TextEditingController();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;


  CollectionReference test =
  FirebaseFirestore.instance.collection('test');

  Future<void> addTest(title, teachers_name, subject,
      section, dateAdded) {
    // Call the user's CollectionReference to add a new user
    return test
        .add({
      'title': title, // John Doe
      'teachers_name': teachers_name, // Stokes and Sons
      'subject': subject,
      'title': title,
      'section': section,
      'dateAdded': dateAdded,
    })
        .then((value) => print("posts Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }
  String selectedLocation = '';

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> _section=[];
    for (int i = 0; i < Teachers.section.length; i++) {

      _section.add(Teachers.section[i]['label']);
    };

    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
          bottomNavigationBar: const Teachersbar(),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: mainColor,
            title: const Text('SCHOOL APP', textAlign: TextAlign.center),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      mediumText('إضافة اختبار', ColorResources.custom, 20)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 350,
                    child: SfCalendar(

         onTap: (calendarTapDetails) {
                    DateTime? now =calendarTapDetails.date;

                    dateController.text = aa.DateFormat('yyyy-MM-dd').format(now!);


         },

                      cellBorderColor: Colors.green,
                      todayHighlightColor:Colors.red ,

                      allowedViews: const <CalendarView>[
                        CalendarView.day,
                        CalendarView.week,
                        CalendarView.workWeek,
                        CalendarView.month,
                        CalendarView.timelineDay,
                        CalendarView.timelineWeek,
                        CalendarView.timelineWorkWeek,
                        CalendarView.schedule
                      ],
                      backgroundColor: ColorResources.greyEDE,
                      appointmentTextStyle: TextStyle(fontFamily: TextFontFamily.KHALED_FONT,color: Colors.black),
                      view: CalendarView.month,
                      dataSource: MeetingDataSource(_getDataSource()),
                      monthViewSettings: const MonthViewSettings(
                          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 250,
                          child: TextField(
                            maxLines: 1,
                            controller: titleController,
                            decoration: InputDecoration(
                              hintText: 'العنوان',
                              hintStyle: TextStyle(fontFamily: TextFontFamily.KHALED_FONT),

                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      mediumText('الفصل الدراسي', ColorResources.black4A4, 16),
                      DropdownButton<String>(
                        hint: bookText(selectedLocation,ColorResources.black4A4,16),


                        items: _section.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: mediumText(value,ColorResources.black4A4,16),
                          );
                        }).toList(),

                        onChanged: (newVal) {

                          selectedLocation=newVal!;
                          print(newVal);

                          this.setState(() {



                          });
                        },
                      ),




                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(child:   Container(
                        child: InkWell(
                          onTap: (){
                            print(dateController.text);

                            addTest(titleController.text,Teachers.name,
                                Teachers.subject,selectedLocation,dateController.text);
                            QuickAlert.show(
                              title: '',
                              text:'تم إضافة الاختبار بنجاح',
                              confirmBtnText: 'موافق',
                              onConfirmBtnTap: () => Get.back(),
                              context: context,
                              type: QuickAlertType.success,
                            );

                          },
                          child: Padding(padding: EdgeInsets.all(20),
                            child:commonButton(null , 'حفظ', ColorResources.custom, ColorResources.whiteF6F) ,

                          ),
                        ),
                      ),)

                    ],
                  ),


                ],
              ),
            ),
          )

      ),

    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
        Meeting('اختبار حاسوب', startTime, endTime, const Color(0xFF0F8644), false),
    );
    meetings.add(
      Meeting('اختبار رياضيات', startTime.add(const Duration(days: 40)), endTime, const Color(0xFF0F8644), false),
    );
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

}