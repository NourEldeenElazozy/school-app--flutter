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
        title:'Title 1',
        body: 'Descrebtion 1',
      ),
      BoardModel(
        image: 'assets/images/bo2.png',
        title: 'Title 2',
        body: 'Descrebtion 2',
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

        body: Column(
          children: <Widget>
          [
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
    );
  }
}