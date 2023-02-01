import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
const mainColor =  Color(0xFF7286D3);
const secondColor =  Color(0xFFE5E0FF);
const defaultColor = Colors.blue;
const grayColor = Color(0xFFE5E5E5);



int currentIndex=0;
class LanguageModel {
  final String language;
  final String code;

  LanguageModel({
    required this.language,
    required this.code,
  });
}

List<LanguageModel> languageList = [
  LanguageModel(
    language: 'English',
    code: 'en',
  ),
  LanguageModel(
    language: 'العربية',
    code: 'ar',
  ),
];



Widget defaultButton({
  required Function function,
  required String text,

}) =>
    Container(

      height: 40.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.circular(
          3.0,
        ),
      ),
      child: MaterialButton(



        onPressed:(){},
        color: secondColor,
        child: Text(

          text.toUpperCase(),

        ),


      ),
    );

void showToast({
  required String text,
  required ToastColors color,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: setToastColor(color),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastColors {
  SUCCESS,
  ERROR,
  WARNING,
}

Color setToastColor(ToastColors color) {
  Color c;

  switch (color) {
    case ToastColors.ERROR:
      c = Colors.red;
      break;
    case ToastColors.SUCCESS:
      c = Colors.green;
      break;
    case ToastColors.WARNING:
      c = Colors.amber;
      break;
  }

  return c;
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
);
