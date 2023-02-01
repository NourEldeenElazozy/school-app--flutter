import 'package:flutter/material.dart';
import 'package:students_mobile/UI/minu.dart';
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
                    width: 300,
                    height: 300,
                    child: Column(
                      children: [
                         Row(
                           children: const [
                             CircleAvatar(
                              radius: 40, // Image radius
                              backgroundImage: AssetImage('assets/images/studentw.png'),
                        ),
                           ],
                         )
                      ],

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
