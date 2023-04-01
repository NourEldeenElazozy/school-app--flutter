import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:students_mobile/Profile/Profile.dart';
import 'package:students_mobile/UI/Teachersbar.dart';
import 'package:students_mobile/UI/minu.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';

import 'package:students_mobile/shared/components/components.dart';

class HomeTeachersScreen extends StatefulWidget {
  @override
  _HomeTeachersScreenState createState() => _HomeTeachersScreenState();
}

class _HomeTeachersScreenState extends State<HomeTeachersScreen> {
  @override
  final CollectionReference posts =
  FirebaseFirestore.instance.collection('posts');
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorResources.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mainColor,
          title: const Text('SCHOOL APP', textAlign: TextAlign.center),
        ),
        body: Column(
          children: [
            Container(
              height: 20,

            ),
            Flexible(
              child: StreamBuilder(
                stream: posts.snapshots(), //build connection
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,  //number of rows
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding:const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Row(

                                        children: [
                                          InkWell(
                                            child: Container(
                                              width: 380,
                                              child: Card(
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0),
                                                    )),
                                                color: Colors.grey[50],
                                                child: Column(
                                                  children: [
                                                    SizedBox(

                                                      child: Column(

                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children:  [
                                                                const CircleAvatar(
                                                                  radius: 20, // Image radius
                                                                  backgroundImage: AssetImage('assets/images/teacher.png'),
                                                                ),
                                                                const SizedBox(width: 10,),
                                                                mediumText( documentSnapshot['teachers_name'].toString(), ColorResources.grey777, 16)


                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children:   [
                                                                SizedBox(
                                                                    width: 350,
                                                                    child: Text(documentSnapshot['content'].toString(),style: TextStyle(color: defaultColor,fontSize: 15,),maxLines: 5)),

                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children:   [
                                                                SizedBox(
                                                                  width: 250,
                                                                  height: 250,
                                                                  child: FittedBox(
                                                                    fit: BoxFit.fill,
                                                                    child: Image.network(documentSnapshot['image']),
                                                                  ),
                                                                ),


                                                              ],
                                                            ),
                                                          ),

                                                        ],
                                                      ),

                                                    ),

                                                  ],
                                                ),

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),

          ],
        ),
        bottomNavigationBar: const Teachersbar(),
      ),
    );
  }}



