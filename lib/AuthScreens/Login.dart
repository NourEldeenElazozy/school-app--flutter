import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:students_mobile/AuthScreens/StudentRegistrationScreen.dart';
import 'package:students_mobile/HomeScreen/HomeScreen.dart';
import 'package:students_mobile/Utiils/User.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:get/get.dart';
import 'package:students_mobile/shared/components/components.dart';




class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String test;
  logInmethod(userName, pass) async {

    await FirebaseFirestore.instance
        .collection('students')
        .where("username", isEqualTo: userName.toString())
        .where("password", isEqualTo: pass.toString())
        .where("status", isEqualTo: true)
        .get()
        .then((event) {
      if (event.docs.isNotEmpty) {
        Map<String, dynamic> documentData =
        event.docs.single.data(); //if it is a single document

        event.docs.forEach((f) {
          User.documentID = f.reference.id;
          print("documentID---- ${f.reference.id}");
        });

        test = "yes data";
        User.name = documentData['studentName'];
        User.phone = documentData['phone'];
        User.password = documentData['password'];
        User.city = documentData['city'];
        User.studentName= documentData['username'];
        User.section = documentData['section']['label'];
        User.idNumber = documentData['idNumber'];
        User.fathername = documentData['parentName'];
        User.age = documentData['age'];

        User.section = documentData['section']['label'];

        //test=documentData['name'];


      }
      if (event.docs.isEmpty) {
        test = "no data";
        print(test);
      }
    }).catchError((e) => print("error fetching data: $e"));
  }
  bool _isObscure = true;
  var userNameController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,

          body:  Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/logo.png'),
                        height: 250.0,

                      ),

                       Text(
                        'WelcomeText'.tr,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        enabled: true,


                        controller: userNameController,
                        //controller: emailController..text = '119900408110',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            print('dd');
                            return 'error';
                          }
                          return null;
                        },
                        decoration:  InputDecoration(
                          prefixIcon: Icon(
                            Icons.supervised_user_circle_outlined,
                          ),
                          labelText: "Username".tr,
                          border: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(20.0)))
                          ,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        enabled: true,
                        controller: passwordController,
                        //controller: passwordController..text = '119900408110',
                        obscureText: _isObscure,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'err';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock_open_outlined,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(  _isObscure ? Icons.visibility_off : Icons.visibility),
                            onPressed: (){
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },

                          ),
                          labelText: 'Password'.tr,
                          hintText: 'Password'.tr,
                          border: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 40.0,
                        width: double.infinity,
                        child: MaterialButton(
                            color: ColorResources.custom,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
        elevation: 10.0,
        


                            onPressed: () async {

                              if (formKey.currentState!.validate()) {
                                await logInmethod(
                                    userNameController.text.toString(),
                                    passwordController.text.toString());
                              if (test == 'no data') {
                              final snackBar = SnackBar(
                              content: mediumText(
                              'ErrorMsg'.tr,
                              ColorResources.whiteF6F,
                              14),
                              backgroundColor: (Colors.red),
                              action: SnackBarAction(
                              label: 'Ok'.tr,
                              onPressed: () {},
                              ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              } else if (test == 'yes data') {
                             Get.off(HomeScreen());
                              }
                              }
                            },child:  Text('Sign in'.tr, style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        child: MaterialButton(
                          
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0), side: 
                              BorderSide(color: ColorResources.custom) ),
                              elevation: 10.0,
        


                              onPressed: () async {
                              Get.to(StudentRegistrationScreen());

                              },child:  mediumText('Create An Account'.tr, ColorResources.custom, 18)
                          ),
                      ),
                      
                     


                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
}
