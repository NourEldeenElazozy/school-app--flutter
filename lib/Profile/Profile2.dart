import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_mobile/AuthScreens/WelcomeScreen.dart';
import 'package:students_mobile/ChatScreen.dart';
import 'package:students_mobile/UI/minu.dart';
import 'package:students_mobile/Utiils/User.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:students_mobile/chatpage..dart';
import 'package:students_mobile/shared/components/components.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({Key? key}) : super(key: key);

  @override
  State<TeacherProfile> createState() => _ProfileState();
}
final List locale =[
  {'name':'ENGLISH','locale': Locale('en','US')},
  {'name':'عربي','locale': Locale('ar', 'LY')},
];
updateLanguage(Locale locale){
  Get.back();
  Get.updateLocale(locale);
}
class _ProfileState extends State<TeacherProfile> { 
   CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grayColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        title: const Text('SCHOOL APP', textAlign: TextAlign.center),
      ),
      body: Column(
        children:  [
          Center(
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: SizedBox(
                width: 350,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                          CircleAvatar(
                            radius: 40, // Image radius
                            backgroundImage: AssetImage('assets/images/teacher.png'),
                          ),
                          mediumText('المعلم/${Teachers.name}', ColorResources.grey777, 20)
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                          mediumText('Phone'.tr, ColorResources.grey777, 20),
                          mediumText(Teachers.phone, ColorResources.grey777, 20)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                          mediumText('city'.tr, ColorResources.grey777, 20),
                          mediumText(Teachers.city, ColorResources.grey777, 20)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                          mediumText('Classes'.tr, ColorResources.grey777, 20),
                          mediumText(Teachers.phone, ColorResources.grey777, 20)
                        ],
                      ),


                    ],

                  ),
                ),

              ),
            ),

          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

              
                Container(
                  width: double.infinity,
                
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){
                        buildLanguageDialog(context);
                      }, child: Text('changelang'.tr), style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        
                      ),),
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),

                    onPressed: (){
                      Get.to(WelcomeScreen());
                    }, child: Text('LogOut'.tr)),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: const bar(),
    );
  }
}

buildLanguageDialog(BuildContext context){
  showDialog(context: context,
      builder: (builder){
        return AlertDialog(
          title: Text('ChooseYourLanguage'.tr),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
                      print(locale[index]['name']);
                      updateLanguage(locale[index]['locale']);
                    },),
                  );
                }, separatorBuilder: (context,index){
              return Divider(
                color: Colors.blue,
              );
            }, itemCount: locale.length
            ),
          ),
        );
      }
  );
}
