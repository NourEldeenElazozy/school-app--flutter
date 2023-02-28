import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:students_mobile/UI/Teachersbar.dart';
import 'package:students_mobile/UI/minu.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:students_mobile/shared/components/components.dart';
import 'package:timeago/timeago.dart' as timeago;

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final CollectionReference Attendance =
      FirebaseFirestore.instance.collection('Attendance');
  List<String> _section = [];

  Future<void> Testmethod() async {
    await FirebaseFirestore.instance.collection('sections').get().then(
      (value) {
        for (var result in value.docs) {
            if (_section.length < value.docs.length) {
              _section.add(
                result['name'],
              );
            }


          }
      },
    );
  }
  Future<void> InsertToAttendance() async {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    await FirebaseFirestore.instance.collection('students').get().then(
          (value) {
            FirebaseFirestore.instance.collection('Attendance')
                .where("ddate", isEqualTo: '${date.year}/${date.month}/${date.day}').
            get().then((value2) => {
              if(value2.docs.isEmpty){

                for (var result in value.docs) {

              FirebaseFirestore.instance.collection('Attendance').add({
                'absence': 0,
                'ddate':'${date.year}/${date.month}/${date.day}',
                'section': result['section.label'],
                'student_name': result['studentName'],
              })
              //result.data(),

            }
              }

            });

      },
    );
  }
  @override
  String selectedLocation = '';
  bool checkedValue = false;
  bool newValue = false;
  List<bool> checkboxValues = List<bool>.generate(10, (index) => false);
  Widget build(BuildContext context) {
    Testmethod();
    InsertToAttendance();
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    //الفنكشن الي تضيف

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mainColor,
          title: const Text('SCHOOL APP', textAlign: TextAlign.center),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mediumText('كشف الحضور و الغياب', ColorResources.custom, 20)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mediumText('اليوم', ColorResources.redF21, 20),
                mediumText('${date.year}/${date.month}/${date.day}',
                    ColorResources.redF21, 20)
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                mediumText('الفصل الدراسي', ColorResources.black4A4, 16),
                FutureBuilder(
                  future: Testmethod(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print('44');
                      return DropdownButton<String>(
                        hint: bookText(
                            selectedLocation, ColorResources.black4A4, 16),
                        items: _section.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child:
                                mediumText(value, ColorResources.black4A4, 16),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          selectedLocation = newVal!;
                          print(newVal);

                          setState(() {});
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ],
            ),
            Flexible(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Attendance')
                    .where('section', isEqualTo: selectedLocation)
                    .where('ddate', isEqualTo: '${date.year}/${date.month}/${date.day}')
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  CollectionReference Attendance =
                      FirebaseFirestore.instance.collection('Attendance');
                  if (streamSnapshot.data!.size == 0) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  //قراءة جدول الطلبة حسب الفصل الدراسي
                  if (streamSnapshot.hasData) {





                    return ListView.builder(
                      itemCount:
                          streamSnapshot.data!.docs.length, //number of rows
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Container(
                          width: 450,
                          height: 80,
                          margin: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.indigo.withOpacity(0.4),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: ColorResources.whiteF6F),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      child: CheckboxListTile(
                                        title: bookText(
                                            documentSnapshot['student_name'],
                                            ColorResources.grey777,
                                            25),
                                        value: documentSnapshot['absence'],
                                        onChanged: (value) {
                                          setState(() {

                                            FirebaseFirestore.instance.collection("Attendance").doc(documentSnapshot.id)
                                                .update({"absence": value}).then(
                                                    (value) {

                                                });


                                            checkboxValues[index] = documentSnapshot['absence'];
                                          });
                                        },
                                        secondary: const Icon(Icons.person,
                                            color: ColorResources.custom),
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        children: [],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
        bottomNavigationBar: const Teachersbar(),
      ),
    );
  }
}
