import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_mobile/UI/minu.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:students_mobile/shared/components/components.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}
final List locale =[
  {'name':'ENGLISH','locale': Locale('en','US')},
  {'name':'عربي','locale': Locale('ar', 'LY')},
];
updateLanguage(Locale locale){
  Get.back();
  Get.updateLocale(locale);
}
class _ProfileState extends State<Profile> {
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
                            backgroundImage: AssetImage('assets/images/studentw.png'),
                          ),
                          mediumText('الطالب/فرج محمد', ColorResources.grey777, 20)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                          mediumText('age'.tr, ColorResources.grey777, 20),
                          mediumText('11', ColorResources.grey777, 20)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                          mediumText('class'.tr, ColorResources.grey777, 20),
                          mediumText('رابعة إبتدائي', ColorResources.grey777, 20)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                          mediumText('city'.tr, ColorResources.grey777, 20),
                          mediumText('طرابلس', ColorResources.grey777, 20)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                          mediumText('fatherMo'.tr, ColorResources.grey777, 20),
                          mediumText('091-1212412', ColorResources.grey777, 20)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                          mediumText('motherMo'.tr, ColorResources.grey777, 20),
                          mediumText('091-1313254', ColorResources.grey777, 20)
                        ],
                      ),

                    ],

                  ),
                ),

              ),
            ),

          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              ElevatedButton(onPressed: (){
                buildLanguageDialog(context);
              }, child: Text('changelang'.tr)),
            ],
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
