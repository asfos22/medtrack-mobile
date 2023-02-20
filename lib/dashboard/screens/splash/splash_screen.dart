import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/slide_model.dart';
import 'package:medtrack/dashboard/walk_through/option_screen.dart';
import 'package:medtrack/repository/utils/helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<SliderModel> slide = <SliderModel>[];
  int slideIndex = 0;
  late PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    slide = getSlides();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppConstants.artBoardBackground),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: AppConstants.artBoardBackground,
            bottomSheet: Container(
              color: AppConstants.whiteColor,
              height: 250, // MediaQuery.of(context).size.height - 100,
              child: Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  PageView(

                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        slideIndex = index;
                      });
                    },
                    children: <Widget>[
                      SlideTile(
                        //imagePath: slide[0].getImageAssetPath()!,
                        title: slide[0].getTitle()!,
                        desc: slide[0].getDesc()!,
                      ),
                      SlideTile(
                        //imagePath: slide[1].getImageAssetPath()!,
                        title: slide[1].getTitle()!,
                        desc: slide[1].getDesc()!,
                      ),
                      SlideTile(
                        //imagePath: slide[2].getImageAssetPath()!,
                        title: slide[2].getTitle()!,
                        desc: slide[2].getDesc()!,
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            /*controller.animateToPage(2,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.linear);*/
                            Helper.navigateToNextPage(
                                context, const OptionScreen());
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    AppConstants.primaryColor.withOpacity(0.5)),
                          ),
                          child: Text(
                            "SKIP",
                            style: TextStyle(
                                color: AppConstants.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(
                          children: [
                            for (int i = 0; i < 3; i++)
                              i == slideIndex
                                  ? _buildPageIndicator(true)
                                  : _buildPageIndicator(false),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            controller.animateToPage(slideIndex + 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.linear);

                            if (slideIndex == 2) {
                              Helper.navigateToNextPage(
                                  context, const OptionScreen());
                            }
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    AppConstants.accentColor.withOpacity(.05)),
                          ),
                          // splashColor: Colors.blue[50],
                          child: Text(
                            "NEXT",
                            style: TextStyle(
                                color: AppConstants.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
  final String? imagePath, title, desc;

  const SlideTile({Key? key, this.imagePath, this.title, this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /*  Image.asset(imagePath),
          SizedBox(
            height: 40,
          ),*/
          Text(
            title!,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppConstants.blackColor,
                fontWeight: FontWeight.w900,
                fontSize: 20),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(desc!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppConstants.subLabelColor,
                  fontWeight: FontWeight.w100,
                  fontSize: 14))
        ],
      ),
    );
  }
}
