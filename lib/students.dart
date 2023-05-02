import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_mobile/Utiils/User.dart';

class StudentGradesScreen extends StatelessWidget {
  final String studentName;
  final List<Map<String, dynamic>> grades;

  StudentGradesScreen({required this.studentName, required this.grades});

  @override
  Widget build(BuildContext context) {
    int total = 0;
    for (var grade in grades) {
      total += int.parse(grade['grade'].toString());
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          title: Text(' $studentName Marks'.tr),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              SizedBox(height: 8),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Dagres')
                        .where('student', isEqualTo: User.studentName)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data!.docs.isEmpty) {
                       return  Center(
                         child: Text(
                            'No marks yet, try again later'.tr,
                            style: TextStyle(fontSize: 22),
                          ),
                       );
                      }else
                        {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {

                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot document =
                                snapshot.data!.docs[index];

                                return Card(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          document['subject'].toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          ' الجزئي ${document['first_grade'].toString()} ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          ' النهائي ${document['second_grade'].toString()} ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          ' الاجمالي ${document['tottal'].toString()} ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }

                    }),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
