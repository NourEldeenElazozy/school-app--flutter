import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:students_mobile/HomeScreen/HomeScreen.dart';
import 'package:students_mobile/HomeScreen/HomeTeachersScreen.dart';
import 'package:students_mobile/Utiils/User.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:get/get.dart';
import 'package:students_mobile/shared/components/components.dart';




class LoginTeachersScreen extends StatefulWidget {
  @override
  _LoginTeachersScreenState createState() => _LoginTeachersScreenState();
}

class _LoginTeachersScreenState extends State<LoginTeachersScreen> {
  late String test;
  logInmethod(userName, pass) async {

    await FirebaseFirestore.instance
        .collection('teachers')
        .where("username", isEqualTo: userName.toString())
        .where("password", isEqualTo: pass.toString())
        .get()
        .then((event) {
      if (event.docs.isNotEmpty) {
        Map<String, dynamic> documentData =
        event.docs.single.data(); //if it is a single document

        event.docs.forEach((f) {
          Teachers.documentID = f.reference.id;
          print("documentID---- ${f.reference.id}");
        });
        print("yes data");
        test = "yes data";
        Teachers.name = documentData['fullName'];
        Teachers.phone = documentData['phone'];
        Teachers.password = documentData['password'];
        Teachers.city = documentData['city'];
        Teachers.subject = documentData['subject'];
        Teachers.section = documentData['section'];
        print("6");
        //test=documentData['name'];

        print(Teachers.section);
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
          appBar: AppBar(  centerTitle: true,backgroundColor: mainColor,
            title:  const Text('SCHOOL APP', textAlign: TextAlign.center),
          ),
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

                      const Text(
                        'Sign in As a teacher to manage your students'
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
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.supervised_user_circle_outlined,
                          ),
                          labelText: "Username",
                          border: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                          labelText: 'Password',
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
        elevation: 18.0,
                            



                            onPressed: () async {

                              if (formKey.currentState!.validate()) {
                                await logInmethod(
                                    userNameController.text.toString(),
                                    passwordController.text.toString());
                                if (test == 'no data') {
                                  final snackBar = SnackBar(
                                    content: mediumText(
                                        'اسم المستخدم او كلمة المرور غير صحيحة',
                                        ColorResources.whiteF6F,
                                        14),
                                    backgroundColor: (Colors.red),
                                    action: SnackBarAction(
                                      label: 'موافق',
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else if (test == 'yes data') {
                                  Get.off(HomeTeachersScreen());
                                }


                                /*
                          LoginCubit.get(context).userLogin(
                            userName: emailController.text,
                            password: passwordController.text,
                          );


                           */
                              }
                            },child: const Text('Sign in', style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),)
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
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
