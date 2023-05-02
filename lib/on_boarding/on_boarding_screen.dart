import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:students_mobile/AuthScreens/WelcomeScreen.dart';
import 'package:students_mobile/Utiils/colors.dart';
import 'package:students_mobile/Utiils/common_widgets.dart';
import 'package:students_mobile/Utiils/text_font_family.dart';
import 'package:students_mobile/shared/components/components.dart';
class BoardModel
{
  final String image;
  final String title;
  final String body;

  BoardModel({required this.image, required this.title, required this.body});
}

class OnBoardScreen extends StatefulWidget
{
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen>
{
  late List<BoardModel> list;

  @override
  void initState()
  {
    super.initState();

    list =
    [
      BoardModel(
        image: 'assets/images/bo1.png',
        title:'Perfect Environment for your children',
        body: 'Our School is Where you can watch your kids school performance from home',
        
      ),
      BoardModel(
        image: 'assets/images/bo2.png',
        title: 'All of your children in one place ',
        body: 'Now you can know when is your kids exam and also track their attendance',
      ),

    ];
  }

  var isLast = false;
  final controller = PageController();

  void submit()
  {

    navigateAndFinish(
      context,
      WelcomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backg.png"),
            fit: BoxFit.cover,
          ),
        ),
          child: Column(
            children: <Widget>
            [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 90,
                  width: 90,
                  child: Image.asset("assets/images/logo.png")),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (i)
                    {
                      if (i == (list.length - 1) && !isLast)
                        setState(() => isLast = true);
                      else if (isLast) setState(() => isLast = false);
                    },
                    controller: controller,
                    itemCount: list.length,
                    itemBuilder: (ctx, i) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    //  mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Image(
                            image: AssetImage(
                              list[i].image,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          
                          list[i].title,
                          style: TextStyle(
                            
                            fontFamily: TextFontFamily.KHALED_FONT,
                            fontSize: 24.0,
                            
                            color:  ColorResources.custom,
                          ),
                          maxLines: 3,
                        ),
                        SizedBox(height: 15.0),
                        mediumText(
                          list[i].body.toString(),
                          ColorResources.custom,
                         16
                         ,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FloatingActionButton(

                      onPressed: ()
                      {
                        if (isLast)
                        {
                          submit();
                        } else
                          controller.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                      },
                      backgroundColor: ColorResources.green,

                        child: Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.white,
                        ),
                      ),

                    SmoothPageIndicator(
                      controller: controller,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: ColorResources.green,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5.0,
                      ),
                      count: list.length,
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}