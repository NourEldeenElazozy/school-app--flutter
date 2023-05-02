
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:students_mobile/UI/minu.dart';
import 'package:students_mobile/Utiils/User.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:students_mobile/shared/components/components.dart';
import 'package:timeago/timeago.dart' as timeago;


class NotificationScreen extends StatelessWidget {
   NotificationScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: 
      
      
      
      
      
      
      
      Column(
        children: [
          Flexible(
            child: StreamBuilder(
              stream:   FirebaseFirestore.instance.collection('notices').where('student', isEqualTo: User.studentName).snapshots(), //build connection
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {

                if (streamSnapshot.hasData) {
                  print(streamSnapshot.data!.docs.length);
                  return ListView.builder(
                    itemCount:streamSnapshot.data!.docs.length,  //number of rows
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                        return Row(
                   mainAxisAlignment: MainAxisAlignment.center,
             
                              children: [

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20, left: 10,right: 10),
                                    child: Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      color: Theme.of(context).colorScheme.surfaceVariant,
                                      child:  SizedBox(
                                        width: 350,
                                        height: 110,
                                        
                                        child: Flexible(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.all(10.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    
                                                    Row(
                                                      children: [
                                                                                             Image(image: AssetImage('assets/images/logo.png'),width: 70,height: 70,fit: BoxFit.cover),

                                                      
                                                           mediumText(documentSnapshot['title'], ColorResources.black4A4, 18),
                                                          
                                                          Icon(Icons.notifications, color: ColorResources.green)      
                                                      ],
                                                    ),
                                                    
                                                    Row(
                                                      

                                                          mainAxisAlignment: MainAxisAlignment.end,
                                  children:  [
                                        mediumText(timeago.format(documentSnapshot['date'].toDate()), ColorResources.grey777, 16),

                                            ],
                                          ),
                                                  ],
                                        ),
                                      ),
                                            ],
                                    ),
                                  ),
                                ),
                           ),
                                  
                                  ),
                                ),  
                        ],
                      
                      ); 


                      // Container(
                      //   width: 450,
                      //   height: 100,

                      //   margin: EdgeInsets.all(10.0),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15.0),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.indigo.withOpacity(0.4),
                      //           spreadRadius: 5,
                      //           blurRadius: 7,
                      //           offset: Offset(0, 3), // changes position of shadow
                      //         ),
                      //       ],
                      //     color: ColorResources.whiteF6F

                      //   ),
                      //   child: Column(
                      //     children: [
                      //       Padding(
                      //         padding:  EdgeInsets.all(4.0),
                      //         child: Column(
                      //           children: [
                      //             Center(
                      //               child: Row(
                      //                 children:  [
                      //                  Image(image: AssetImage('assets/images/logo.png'),width: 120,height: 120,fit: BoxFit.cover),
                      //                   bookText(
                      //                       documentSnapshot['title'].toString(), ColorResources.grey777, 18),

                      //                 ],
                      //               ),
                                    
                      //             ),
                      //             Center(
                      //               child: Row(

                      //                 mainAxisAlignment: MainAxisAlignment.center,

                      //                 children:  [
                      //                   mediumText(timeago.format(documentSnapshot['date'].toDate()), ColorResources.grey777, 16),



                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ),

                      //       )
                      //     ],
                      //   ),
                      // );
                    },
                  );
                }

                return  Center(
                  child: Image.asset("assets/images/empty.png"),
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: const bar(),
    );
  }
}
