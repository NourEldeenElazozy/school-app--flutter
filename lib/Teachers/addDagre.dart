import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:students_mobile/Utiils/User.dart';
import 'package:students_mobile/shared/components/components.dart';
class GradeEntryScreen extends StatefulWidget {

  GradeEntryScreen(@required this.searchResult,);
  final String searchResult;

  @override
  State<GradeEntryScreen> createState() => _GradeEntryScreenState();
}

class _GradeEntryScreenState extends State<GradeEntryScreen> {
  final TextEditingController firstGradeController = TextEditingController();

  final TextEditingController secondGradeController = TextEditingController();
  String? _selectedSubject;
  List<String> _subjects = [
    'علوم',
    'رياضيات',
    'تاريخ',
    'جغرافيا',
    'لغة عربية',
    'لغة إنجليزية',
    'فيزياء',
    'كيمياء',
  ];

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
        ),
        body: Column(
          children: [



            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(

                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'اعمال السنه',
                          border: OutlineInputBorder(),
                        ),
                        controller: firstGradeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يرجى إدخال الدرجة ';
                          }
                          final number = double.tryParse(value);
                          if (number == null) {
                            return 'يرجى إدخال رقم صالح';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'امتحان نهائي',
                          border: OutlineInputBorder(),
                        ),
                        controller: secondGradeController,

                        validator: (value) {

                          if (value!.isEmpty) {
                            return 'يرجى إدخال الدرجة ';
                          }
                          final number = double.tryParse(value);
                          if (number == null) {
                            return 'يرجى إدخال رقم صالح';
                          }
                          return null;
                        },
                      ),


                    ],
                  ),
                ),

              ),
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // تعيين لون الخلفية
                ),

                onPressed: () {
                  final firstGrade = double.tryParse(firstGradeController.text);
                  final secondGrade = double.tryParse(secondGradeController.text);

                  if (firstGrade != null && secondGrade != null) {
                    FirebaseFirestore.instance.collection('Dagres').add({
                      'subject': Teachers.subject,
                      'student': widget.searchResult,
                      'first_grade': firstGrade,
                      'second_grade': secondGrade,
                      'tottal': double.parse(firstGradeController.text)+double.parse(secondGradeController.text),
                    }).then((value) {
                      // تنفيذ الخطوات اللازمة عند الحفظ بنجاح
                      Navigator.pop(context);
                    }).catchError((error) {
                      // تنفيذ الخطوات اللازمة عند حدوث خطأ أثناء الحفظ
                      print(error);
                    });
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('يرجي مراجعة البيانات'),
                      ),
                    );
                  }
                },
                child: const Text('حفظ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}