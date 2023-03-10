
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:students_mobile/UI/minu.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:students_mobile/shared/components/components.dart';
import 'package:timeago/timeago.dart' as timeago;


class NotificationScreen extends StatelessWidget {
   NotificationScreen({Key? key}) : super(key: key);
  final CollectionReference Notices =
  FirebaseFirestore.instance.collection('Notices');
  @override

  Widget build(BuildContext context) {

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
            Flexible(
              child: StreamBuilder(
                stream: Notices.snapshots(), //build connection
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      itemCount:streamSnapshot.data!.size,  //number of rows
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                        return Container(
                          width: 450,
                          height: 180,

                          margin: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.indigo.withOpacity(0.4),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            color: ColorResources.whiteF6F

                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Row(
                                        children:  [
                                         Image(image: AssetImage('assets/images/logo.png'),width: 120,height: 120,fit: BoxFit.cover),
                                          bookText(
                                              documentSnapshot['description'], ColorResources.grey777, 25),

                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Row(

                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children:  [
                                          mediumText(timeago.format(documentSnapshot['date'].toDate()), ColorResources.grey777, 25),



                                        ],
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
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
        bottomNavigationBar: const bar(),
      ),
    );
  }
}
