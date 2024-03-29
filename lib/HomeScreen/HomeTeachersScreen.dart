import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:students_mobile/Profile/Profile.dart';
import 'package:students_mobile/Teachers/addDagre.dart';
import 'package:students_mobile/UI/Teachersbar.dart';
import 'package:students_mobile/UI/minu.dart';
import 'package:students_mobile/Utiils/User.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:get/get.dart';
import 'package:students_mobile/shared/components/components.dart';

import '../Profile/Profile2.dart';

class HomeTeachersScreen extends StatefulWidget {
  @override
  _HomeTeachersScreenState createState() => _HomeTeachersScreenState();
}

class _HomeTeachersScreenState extends State<HomeTeachersScreen> {

  String selectedLocation = '';

  TextEditingController searchController = TextEditingController();
  bool _showWidget = false;
  List<Map<String, dynamic>> _searchResults = [];
  @override
  Future<void> searchUser(String username) async {
    try {
      print(_searchResults.length);
      var snapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('studentName', isEqualTo: username).where('section.label', isEqualTo: selectedLocation)
          .get();

      setState(() {
        _searchResults = snapshot.docs.map((doc) => doc.data()).toList();
        print(_searchResults.length);
      });

      if (_searchResults.isEmpty) {
        print('No matching user found.');
      } else {
        _searchResults.forEach((result) {
          print('Found user: $result');
        });
      }
    } catch (e) {
      print('Error searching for user: $e');
    }
  }
  final CollectionReference posts =
  FirebaseFirestore.instance.collection('posts');
  Widget build(BuildContext context) {
    List<String> _section=[];
    var size, height, width;
    size = MediaQuery.of(context).size;
    for (int i = 0; i < Teachers.section.length; i++) {

      _section.add(Teachers.section[i]['label']);
    };

    height = size.height;
    width = size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorResources.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
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
          backgroundColor: Colors.white,
          title: TextField(
            

            controller: searchController,
            onChanged: (value) {
              searchUser(value);
              if(value.length>0){
                setState(() {
                  _showWidget=true;
                });

              }else{
                setState(() {
                  _showWidget=false;
                });
              }
            },

            decoration: InputDecoration(
              hintText: 'Search For Student'.tr,
              prefixIcon: Icon(Icons.search)
            
            ),
          ),

        ),
        body: !_showWidget?Column(
          children: [
            Container(
              height: 20,

            ),
            Flexible(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .where("teachers_name", isEqualTo:  Teachers.name)

                    .snapshots(), //build connection
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(

                      itemCount: streamSnapshot.data!.docs.length,  //number of rows
                      itemBuilder: (context, index) {

                        final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                        final item =streamSnapshot.data!.docs[index];
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
                                              child: Dismissible(

                                                onDismissed: (_) {
                                                  setState(() {
                                                    final collection = FirebaseFirestore.instance.collection('posts').doc(documentSnapshot.id).delete().then((value) {
                                                      ScaffoldMessenger.of(context)
                                                          .showSnackBar(SnackBar(content: Text('Post Deleted'.tr),backgroundColor: Colors.red,));
                                                    },);

                                                  });
                                                },
                                                key: UniqueKey(),
                                                direction: DismissDirection.endToStart,
                                                background: Container(

                                                  color: Colors.red,
                                                  margin:  EdgeInsets.symmetric(horizontal: 15),
                                                  alignment: Alignment.centerLeft,

                                                ),
                                                child:
                                                 Card(
         shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0), side: 
                              BorderSide(color: ColorResources.black4A4.withAlpha(30)) ),
                              elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                 
                     Row(
                      children: <Widget>[

                        InkWell(
                          onTap: (){
                            Get.to(TeacherProfile());
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/teacher.png"),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(documentSnapshot['teachers_name'], style: TextStyle(color: Colors.grey[900], fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),),
                            SizedBox(height: 3,),
                            Text(documentSnapshot['date'], style: TextStyle(fontSize: 15, color: Colors.grey),),
                          ],
                        )
                      ],
                    ),
                  
                  IconButton(
                    icon: Icon(Icons.delete, size: 20, color: Colors.red[600],), 
                    onPressed: () {
                        setState(() {
                                                    final collection = FirebaseFirestore.instance.collection('posts').doc(documentSnapshot.id).delete().then((value) {
                                                      ScaffoldMessenger.of(context)
                                                          .showSnackBar(SnackBar(content: Text('تم حذف المنشور'),backgroundColor: Colors.red,));
                                                    },);

                                                  });
                    },
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text(documentSnapshot['title'], style: TextStyle(fontSize: 15, color: Colors.grey[800], height: 1.5, letterSpacing: .7),),
              Text(documentSnapshot['content'], style: TextStyle(fontSize: 15, color: Colors.grey[800], height: 1.5, letterSpacing: .7),),
      
              SizedBox(height: 20,),
             Image.network(documentSnapshot['image']) != '' ?
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(documentSnapshot['image']),
                    fit: BoxFit.cover
                  )
                ),
              ) : Container(),
           
             
            ],
          ),
        ),
      ),
                                                //  Card(
                                                //   shape: const RoundedRectangleBorder(
                                                //       borderRadius: BorderRadius.all(
                                                //         Radius.circular(20.0),
                                                //       )),
                                                //   color: Colors.grey[50],
                                                //   child: Column(
                                                //     children: [
                                                //       SizedBox(

                                                //         child: Column(

                                                //           children: [
                                                //             Padding(
                                                //               padding: const EdgeInsets.all(8.0),
                                                //               child: Row(
                                                //                 children:  [
                                                //                   const CircleAvatar(
                                                //                     radius: 20, // Image radius
                                                //                     backgroundImage: AssetImage('assets/images/teacher.png'),
                                                //                   ),
                                                //                   const SizedBox(width: 10,),
                                                //                   mediumText( documentSnapshot['teachers_name'].toString(), ColorResources.grey777, 16)


                                                //                 ],
                                                //               ),
                                                //             ),
                                                //             Padding(
                                                //               padding: const EdgeInsets.all(8.0),
                                                //               child: Row(
                                                //                 children:   [
                                                //                   SizedBox(
                                                //                       width: 350,
                                                //                       child: Text(documentSnapshot['content'].toString(),style: TextStyle(color: defaultColor,fontSize: 15,),maxLines: 5)),

                                                //                 ],
                                                //               ),
                                                //             ),
                                                //             Padding(
                                                //               padding: const EdgeInsets.all(8.0),
                                                //               child: Row(
                                                //                 mainAxisAlignment: MainAxisAlignment.center,
                                                //                 children:   [
                                                //                   SizedBox(
                                                //                     width: 250,
                                                //                     height: 250,
                                                //                     child: FittedBox(
                                                //                       fit: BoxFit.fill,
                                                //                       child: Image.network(documentSnapshot['image']),
                                                //                     ),
                                                //                   ),


                                                //                 ],
                                                //               ),
                                                //             ),

                                                //           ],
                                                //         ),

                                                //       ),

                                                //     ],
                                                //   ),

                                                // ),

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
        ):

        Container(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) => Card(
              
              elevation: 4,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(10),
                
              ),
              
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                onTap: () {
                 Get.to(GradeEntryScreen( _searchResults[index]['username']));
                },
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _searchResults[index]['username'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset("assets/images/studentw.png")),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        _searchResults[index]['studentName'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16.0,
                        ),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الفصل: ${_searchResults[index]['section']['label']}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'العمر: ${_searchResults[index]['age']}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'اسم الأب: ${_searchResults[index]['parentName']}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'رقم الهاتف: ${_searchResults[index]['phone']}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar:  Teachersbar(),
      ),
    );
  }}

