import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:students_mobile/Utiils/User.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';
class messages extends StatefulWidget {
  String email;
  messages({required this.email});
  @override
  _messagesState createState() => _messagesState(email: email);
}

class _messagesState extends State<messages> {
  logInmethod(sender) async {
    await FirebaseFirestore.instance
        .collection('services')

        .where("sender", isEqualTo: User.name)
        .get()
        .then((event) {
      if (event.docs.isNotEmpty) {
        Map<String, dynamic> documentData =
        event.docs.single.data(); //if it is a single document

        event.docs.forEach((f) {
          User.documentID = f.reference.id;
          print("documentID---- ${f.reference.id}");
        });

        print("msg---- ${documentData['text']}");

      }

    }).catchError((e) => print("error fetching data: $e"));
  }
  String email;
  _messagesState({required this.email});

  final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection('services')
      .orderBy("date",descending: false)
     .where("sender", whereIn: [User.name, "admin"])
      .where("ticket", isEqualTo: User.ticket)



      .snapshots();
  @override
  Widget build(BuildContext context) {
    logInmethod(1);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: StreamBuilder(
        stream: _messageStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text("Text is refreshing");
          }


          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            itemBuilder: (_, index) {
              QueryDocumentSnapshot qs = snapshot.data!.docs[index];
              print('qs');
              print(snapshot.data!.docs.length);
              return Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8,left: 8,right: 8),
                child: Column(
                  crossAxisAlignment: email == qs['sender'].toString()
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigo.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: ColorResources.whiteF6F),

                      child: SizedBox(
                        width: 300,
                        child: ListTile(


                          title: mediumText(
                            qs['sender'],Colors.green,18

                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(


                                child: mediumText(
                                    qs['text'],ColorResources.blue0C1,16

                                ),
                              ),
                              mediumText(timeago.format(qs['date'].toDate()), ColorResources.grey777, 12),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}