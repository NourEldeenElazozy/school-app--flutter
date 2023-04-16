import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_mobile/AuthScreens/WelcomeScreen.dart';
import 'package:students_mobile/UI/minu.dart';
import 'package:students_mobile/Utiils/User.dart';
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
    return  Scaffold(
      backgroundColor: grayColor,
      
      body: Column(
        children:  [
          Center(
            child: Flexible(
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
                  
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            
                            mediumText('Student/${User.name}', ColorResources.grey777, 20),
                            SizedBox(width: 10,),
                        CircleAvatar(
                              radius: 40, // Image radius
                              backgroundImage: AssetImage('assets/images/studentw.png'),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
            
                        Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                          
                            mediumText(User.section, ColorResources.grey777, 18),
                               SizedBox(width: 10,),
            
                              mediumText('Grade:'.tr, ColorResources.grey777, 20),
                          ],
                        ),
                                              SizedBox(height: 10,),
            
                        Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            mediumText(User.city, ColorResources.grey777, 18),
                               SizedBox(width: 10,),
            
                             mediumText(':المدينة'.tr, ColorResources.grey777, 20),
            
                          ],
                        ),
                                              SizedBox(height: 10,),
            
                        Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            mediumText(User.phone, ColorResources.grey777, 18),
                               SizedBox(width: 10,),
            
                                mediumText(':رقم ولي الأمر'.tr, ColorResources.grey777, 20),
            
                          ],
                        ),                      SizedBox(height: 10,),
            
            
                            Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            mediumText("احمد", ColorResources.grey777, 18),
                               SizedBox(width: 10,),
            
                                mediumText(':اسم ولي الأمر'.tr, ColorResources.grey777, 20),
            
                          ],
                        ),
                        SizedBox(height: 10,),
            
                          Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            mediumText("1111111101", ColorResources.grey777, 18),
                               SizedBox(width: 10,),
            
                                mediumText(':الرقم الوطني'.tr, ColorResources.grey777, 20),
            
                          ],
                        ),
                                              SizedBox(height: 10,),
            
                         Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            mediumText("12", ColorResources.grey777, 18),
                               SizedBox(width: 10,),
            
                                mediumText(':العمر'.tr, ColorResources.grey777, 20),
            
                          ],
                        ),
                                              SizedBox(height: 10,),
            
                        Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            mediumText("طرابلس", ColorResources.grey777, 18),
                               SizedBox(width: 10,),
            
                                mediumText(':العنوان'.tr, ColorResources.grey777, 20),
            
                          ],
                        ),
                                              SizedBox(height: 10,),
            
                        
                      ],
            
                    ),
                  ),
            
                ),
              ),
            ),

          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Settings", style: TextStyle(color: Colors.grey, fontSize: 18),),


              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                
                child: MaterialButton( 
                     shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0), side: 
                              BorderSide(color: ColorResources.custom) ),
                              color: ColorResources.custom, 
                  onPressed: (){
                  buildLanguageDialog(context);
                }, child: Text('Chnage Language'.tr, style: TextStyle(color: Colors.white),)),
              ),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.headphones,color: Colors.white,),
                    Text("Contact Head Office")
                ],)
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),

                  onPressed: (){
              Get.to(WelcomeScreen());
              }, child: Text('LogOut'.tr)),
            ],
          )
        ],
      ),
      bottomNavigationBar: const bar(),
    );
    
  //   Scaffold(
  //     body: Column(
  //       children: [
  //         AppBar(
  //           backgroundColor: Colors.transparent,
  //           elevation: 0,
  //           toolbarHeight: 10,
  //         ),
  //         Center(
  //             child: Padding(
  //                 padding: EdgeInsets.only(bottom: 20),
  //                 child: Text(
  //                   'My Profile',
  //                   style: TextStyle(
  //                     fontSize: 25,
  //                     fontWeight: FontWeight.w700,
  //                     color: Colors.black26,
  //                   ),
  //                 ))),
  //         InkWell(
  //             onTap: () {
  //               //navigateSecondPage(EditImagePage());
  //             },
  //             child: SizedBox(
  //               height: 150,
  //               width: 150,
  //               child: Image.asset("assets/images/studentw.png"))
  //             ),
              
  //         buildUserInfoDisplay(User.name, 'Student Name', Icons.person),
  //         buildUserInfoDisplay("12", 'Age' ,Icons.man),
  //         buildUserInfoDisplay("tripoli", 'Address' ,Icons.man),

  //         buildUserInfoDisplay(User.phone, 'Parent Phone' , Icons.phone),
  //         buildUserInfoDisplay("احمد", 'Parent Name' ,Icons.man),
  //         Expanded(
  //           child: buildAbout(),
  //           flex: 4,
  //         )
  //       ],
  //     ),
  //   );
  // }

  // // Widget builds the display item with the proper formatting to display the user's info
  // Widget buildUserInfoDisplay(String getValue, String title, IconData icondata) =>
  //     Padding(
  //         padding: EdgeInsets.only(bottom: 10),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.w500,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //             SizedBox(
  //               height: 1,
  //             ),
  //             Container(
  //                 width: 350,
  //                 height: 40,
  //                 decoration: BoxDecoration(
  //                     border: Border(
  //                         bottom: BorderSide(
  //                   color: Colors.grey,
  //                   width: 1,
  //                 ))),
  //                 child: Row(children: [
  //                   Expanded(
  //                       child: TextButton(
  //                           onPressed: () {
  //                            // navigateSecondPage(editPage);
  //                           },
  //                           child: Text(
  //                             getValue,
                              
  //                             style: TextStyle(fontSize: 16, height: 1.4, color: Colors.black),
  //                           ))),
  //                   Icon(
  //                     icondata,
  //                     color: Colors.grey,
  //                     size: 20.0,
  //                   )
  //                 ]))
  //           ],
  //         ));

  // // Widget builds the About Me Section
  // Widget buildAbout() => Padding(
  //     padding: EdgeInsets.only(bottom: 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Tell Us About Yourself',
  //           style: TextStyle(
  //             fontSize: 15,
  //             fontWeight: FontWeight.w500,
  //             color: Colors.grey,
  //           ),
  //         ),
  //         const SizedBox(height: 1),
  //         Container(
  //             width: 350,
  //             height: 200,
  //             decoration: BoxDecoration(
  //                 border: Border(
  //                     bottom: BorderSide(
  //               color: Colors.grey,
  //               width: 1,
  //             ))),
  //             child: Row(children: [
  //               Expanded(
  //                   child: TextButton(
  //                       onPressed: () {
  //                        // navigateSecondPage(EditDescriptionFormPage());
  //                       },
  //                       child: Padding(
  //                           padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
  //                           child: Align(
  //                               alignment: Alignment.topLeft,
  //                               child: Text(
  //                                 "user.aboutMeDescription",
  //                                 style: TextStyle(
  //                                   fontSize: 16,
  //                                   height: 1.4,
  //                                 ),
  //                               ))))),
  //               Icon(
  //                 Icons.keyboard_arrow_right,
  //                 color: Colors.grey,
  //                 size: 40.0,
  //               )
  //             ]))
  //       ],
  //     ));

    
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
}