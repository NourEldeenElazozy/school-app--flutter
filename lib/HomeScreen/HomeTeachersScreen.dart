import 'package:flutter/material.dart';
import 'package:students_mobile/Profile/Profile.dart';
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
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: grayColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mainColor,
          title: const Text('SCHOOL APP', textAlign: TextAlign.center),
        ),
        body: Column(
          children: [
            Container(
              height: 80,
              child: Row(
                children:  [
                  InkWell(
                    child: const CircleAvatar(
                      radius: 48, // Image radius
                      backgroundImage: AssetImage('assets/images/studentw.png'),
                    ),
                    onTap: (){
                      navigateTo(
                        context,
                        const Profile(),
                      );
                    },
                  )
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [

                          Row(
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
                                                        width:
                                                        MediaQuery.of(context).size.width * 12,
                                                        height:
                                                        MediaQuery.of(context).size.height * 0.55,
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
                                                                  mediumText('ابلة فاطمة', ColorResources.grey777, 16)


                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                children:  const [
                                                                  SizedBox(
                                                                      width: 350,
                                                                      child: Text('كل شيء نسبي في الحياة ، ومهما ساءت الأمور فليست شرا كلها ، ولن تجد الناس جميعا يجمعون على أمر واحد ، خاصة إذا تعلق الأمر بالفنون التعبيرية ودورها في تثقيف الإنسان والتعبير عن قضاياه ، ومن هذه الفنون الأدب والسينما . فما العلاقة بينهما ؟ وكيف يؤثران في شخصية الإنسان ؟',style: TextStyle(color: defaultColor,fontSize: 15,),maxLines: 5)),

                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children:   [
                                                                  SizedBox(
                                                                    width: 100,
                                                                    height: 100,
                                                                    child: FittedBox(
                                                                      fit: BoxFit.fill,
                                                                      child: Image.asset('assets/images/book.png'),
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
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
        bottomNavigationBar: const bar(),
      ),
    );
  }}



