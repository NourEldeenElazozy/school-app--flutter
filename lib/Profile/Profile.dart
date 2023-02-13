import 'package:flutter/material.dart';
import 'package:students_mobile/UI/minu.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:students_mobile/shared/components/components.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            mediumText('العمر:', ColorResources.grey777, 20),
                            mediumText('11', ColorResources.grey777, 20)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            mediumText('الفصل:', ColorResources.grey777, 20),
                            mediumText('رابعة إبتدائي', ColorResources.grey777, 20)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            mediumText('المدينة:', ColorResources.grey777, 20),
                            mediumText('طرابلس', ColorResources.grey777, 20)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            mediumText('رقم هاتف الأب:', ColorResources.grey777, 20),
                            mediumText('091-1212412', ColorResources.grey777, 20)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            mediumText('رقم هاتف الأم:', ColorResources.grey777, 20),
                            mediumText('091-1313254', ColorResources.grey777, 20)
                          ],
                        ),

                      ],

                    ),
                  ),
                ),
              ),

            ),
          ],
        ),
        bottomNavigationBar: const bar(),
      ),

    );
  }
}
