import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rootscards/config/colors.dart';

class TestOnboarding extends StatefulWidget {
  static const String routeName = "test_onboarding_screen";
  const TestOnboarding({super.key});

  @override
  State<TestOnboarding> createState() => _TestOnboardingState();
}

class _TestOnboardingState extends State<TestOnboarding> {
  static const _carouselImages = <String>[
    "onboarding_1.png",
    "onboarding_2.png",
    "onboarding_3.png",
  ];

  static const _carouselTitles = <String>[
    "A creative handy tool.",
    "A creator’s handy tool.",
    "Stand Out!",
  ];

  static const _carouselTexts = <String>[
    "Optimize what works with Insights to know and\n understand your audience, allowing you fly high.",
    "Optimize what works with Insights to know and\n understand your audience, allowing you fly high.",
    "Optimize what works with Insights to\nknow and understand your audience,\n allowing you fly high.",
  ];

  final CarouselController _carouselController = CarouselController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Expanded(
              flex: 8,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: height * .1),
                    CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount: 3,
                      itemBuilder: (context, index, realIndex) =>
                          _CarouselImage(
                        image: _carouselImages[index],
                        title: _carouselTitles[index],
                        subTitle: _carouselTexts[index],
                        viewPortHeight: height,
                      ),
                      options: CarouselOptions(
                        initialPage: 0,
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                        height: 0.85 * height <= 500 ? 0.75 * height : 500,
                        autoPlayInterval: Duration(seconds: 4),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        onPageChanged: (newIndex, reason) => setState(() {
                          _currentIndex = newIndex;
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
  
}



class _CarouselImage extends StatelessWidget {
  final Key? key;
  final String image;
  final String title;
  final String subTitle;
  final double viewPortHeight;

  _CarouselImage({
    this.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.viewPortHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: 
          
          Image.asset(
            "assets/images/" + image,
            height: viewPortHeight * .38,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20, bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 25,
                color: BLACK,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin:
              EdgeInsets.only(bottom: 0.45 * viewPortHeight <= 350 ? 20 : 3),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.1,
            ),
          ),
        ),
      ],
    );
  }
}