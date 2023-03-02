// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0
import 'package:intl/intl.dart' as aa;

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:students_mobile/Calendar2.dart';
import 'package:students_mobile/HomeScreen/HomeTeachersScreen.dart';
import 'package:students_mobile/Notification/notification_screen.dart';
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

class TableEventsExample extends StatefulWidget {
  const TableEventsExample({super.key});

  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
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

  CollectionReference test = FirebaseFirestore.instance.collection('test');

  Future<void> addTest(title, teachers_name, subject, section, dateAdded) {
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

  Future<void> Testmethod() async {
    meetings.clear();
    await FirebaseFirestore.instance
        .collection('test')
        .where("section", isEqualTo: User.section)
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (result) {
            if (meetings.length < value.docs.length) {
              meetings.add(
                Meeting(
                    result['title'] + result['subject'],
                    DateTime.parse(result['dateAdded']),
                    DateTime.parse(result['dateAdded']),
                    const Color(0xFF0F8644),
                    false),
              );
            }

            FirebaseFirestore.instance.collection('myOtherCollection222').add(
                  result.data(),
                );
          },
        );
      },
    );
  }

  Testmethod2() async {
    await FirebaseFirestore.instance
        .collection('test')
        .where("section", isEqualTo: User.section)
        .get()
        .then((event) {
      if (event.docs.isNotEmpty) {
        print(event.docs.single['teachers_name']);
      }

      if (event.docs.isEmpty) {
        print('no data');
      }
    }).catchError((e) => print("error fetching data: $e"));
  }

  final List<Meeting> meetings = <Meeting>[];
  @override
  Widget build(BuildContext context) {
    Testmethod();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            bottomNavigationBar: const bar(),
            appBar: AppBar(
              bottom:  TabBar(
                tabs: [
                  Tab(child: mediumText('المهام الاسبوعية', ColorResources.white, 18),),
                  Tab(child: mediumText('الحضور و الغياب', ColorResources.white, 18),),

                ],
              ),
              centerTitle: true,
              backgroundColor: mainColor,
              title: const Text('SCHOOL APP', textAlign: TextAlign.center),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            mediumText('الإختبارات و المهام الإسبوعية',
                                ColorResources.custom, 20)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 500,
                          child: FutureBuilder(
                              future: Testmethod(),
                              builder: (ctx, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  print('done');
                                  return SfCalendar(
                                    onTap: (calendarTapDetails) {
                                      print(meetings);
                                      DateTime? now = calendarTapDetails.date;

                                      dateController.text =
                                          aa.DateFormat('yyyy-MM-dd').format(now!);
                                    },
                                    cellBorderColor: Colors.green,
                                    todayHighlightColor: Colors.red,
                                    backgroundColor: ColorResources.greyEDE,
                                    appointmentTextStyle: TextStyle(
                                        fontFamily: TextFontFamily.KHALED_FONT,
                                        color: Colors.black),
                                    view: CalendarView.schedule,
                                    dataSource: MeetingDataSource(_getDataSource()),
                                    monthViewSettings: const MonthViewSettings(
                                        appointmentDisplayMode:
                                        MonthAppointmentDisplayMode.appointment),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                CalendarApp(),






              ],

            )),
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime.parse("2023-03-01");
    final DateTime endTime = startTime.add(const Duration(hours: 2));

/*
 meetings.add(
      Meeting('saAA', DateTime.parse("2023-03-01"), endTime, const Color(0xFF0F8644), false),
    );

 */

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
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
