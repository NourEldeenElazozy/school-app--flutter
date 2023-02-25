import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart' as a;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

import 'package:quickalert/quickalert.dart';
import 'package:students_mobile/AuthScreens/Login.dart';
import 'package:students_mobile/HomeScreen/HomeTeachersScreen.dart';
import 'package:students_mobile/UI/Teachersbar.dart';
import 'package:students_mobile/Utiils/User.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:students_mobile/Utiils/images.dart';
import 'package:students_mobile/Utiils/text_font_family.dart';
import 'package:students_mobile/shared/components/components.dart';

class AddPostScreen extends StatefulWidget {
  AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController contentController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');

  Future<void> addPosts(content, section, teachers_name, title,
       image, dateAdded) {
    // Call the user's CollectionReference to add a new user
    return posts
        .add({
          'content': content, // John Doe
          'section': section, // Stokes and Sons
          'teachers_name': teachers_name,
          'title': title,
          'image': image,
          'date': dateAdded,
        })
        .then((value) => print("posts Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  String selectedLocation = '';



  final ImagePicker _picker = ImagePicker();
  var imageurl;
  File? _photo;
  // ignore: prefer_typing_uninitialized_variables

  bool isImageChange = false;

  Future uploadFile() async {
    if (_photo == null) return;

    final fileName = basename(_photo!.path);
    final destination = 'reports/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);

      await ref.putFile(_photo!);

      await ref.getDownloadURL().then((value) => (imageurl = value));
    } catch (e) {
      print(e);
    }
  }

  _getImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  _getImageCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  int _index = 0;



  @override
  Widget build(BuildContext context) {
    List<String> _section=[];
    for (int i = 0; i < Teachers.section.length; i++) {

      _section.add(Teachers.section[i]['label']);
    };
    print(_section);
    DateTime today = new DateTime.now();
    String dateSlug =
        "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    print('dateSlug=$dateSlug');
    final name = Teachers.name;




    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mainColor,
          title: const Text('SCHOOL APP', textAlign: TextAlign.center),
        ),
        backgroundColor: ColorResources.whiteF6F,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 350,
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        color: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 10,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                  leading: const CircleAvatar(
                                    radius: 30, // Image radius
                                    backgroundImage: AssetImage(
                                        'assets/images/instagram-post.png'),
                                  ),
                                  title: mediumText('المعلم/$name',
                                      ColorResources.grey777, 20)),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  width: 250,
                                  child: TextField(
                                    maxLines: 1,
                                    controller: titleController,
                                    decoration: InputDecoration(
                                      hintText: 'عنوان المنشور',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Colors.blue), //<-- SEE HERE
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  width: 250,
                                  child: TextField(
                                    maxLines: 10,
                                    controller: contentController,
                                    decoration: InputDecoration(
                                      hintText: 'محتوي المنشور',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Colors.blue), //<-- SEE HERE
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  )),
                              Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Stack(
                                    alignment: Alignment.topCenter,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Center(
                                        child: Container(
                                          height: 170,
                                          width: 170,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: ColorResources.greyEDE,
                                          ),
                                          child: _photo == null
                                              ? Center(
                                                  child: Container(
                                                  height: 200,
                                                  width: 500,
                                                  decoration:
                                                  const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/instagram-post.png'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: Image.file(
                                                    File.fromUri(Uri.parse(
                                                        _photo!.path)),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 80,
                                        top: -10,
                                        child: InkWell(
                                          onTap: () {
                                            Get.bottomSheet(
                                              Container(
                                                height: 100,
                                                width: Get.width,
                                                color: ColorResources.white,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              _getImageCamera();
                                                              Get.back();
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .camera_alt_outlined,
                                                              color:
                                                                  ColorResources
                                                                      .green009,
                                                              size: 28,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Camera",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  ColorResources
                                                                      .black,
                                                              fontFamily:
                                                                  TextFontFamily
                                                                      .AVENIR_LT_PRO_BOOK,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        width: 80,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              _getImageGallery();
                                                              Get.back();
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .image_outlined,
                                                              color:
                                                                  ColorResources
                                                                      .green009,
                                                              size: 28,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Gallery",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  ColorResources
                                                                      .black,
                                                              fontFamily:
                                                                  TextFontFamily
                                                                      .AVENIR_LT_PRO_BOOK,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },

                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                ColorResources.green009,
                                            child: Image.asset('assets/images/camera.png', width: 25, fit: BoxFit.cover,
                                               ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                   SizedBox(height: 2),
                                 Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      mediumText('الفصل الدراسي', ColorResources.black4A4, 16),
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
                                  ),




                                ],
                              ),
                            ],

                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  imageurl ??= 'https://firebasestorage.googleapis.com/v0/b/educational-platform-8dd63.appspot.com/o/299517.webp?alt=media&token=4f7bdb37-a6ee-4c47-a22c-649b7a6af04b';;
                  addPosts(contentController.text,selectedLocation,
                      Teachers.name,titleController.text,imageurl,dateSlug);
                  QuickAlert.show(
                    title: '',
                    text:'تم إضافة المنشور بنجاح',
                    confirmBtnText: 'موافق',
                    onConfirmBtnTap: () => Get.to(HomeTeachersScreen()),
                    context: context,
                    type: QuickAlertType.success,
                  );

                },
                child: Padding(padding: EdgeInsets.all(20),
                  child:commonButton(null , 'حفظ', ColorResources.custom, ColorResources.whiteF6F) ,

                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const Teachersbar(),
      ),
    );
  }
}
