import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/get_started_screen.dart';
import 'package:rootscards/presentation/screens/auth/sign_in.dart';
import 'package:rootscards/presentation/screens/widgets/carousel_inidicator.dart';
import 'package:rootscards/presentation/screens/widgets/skip_button.dart';
import 'package:sizer/sizer.dart';

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
    "A creator's handy tool.",
    "Stand Out!",
  ];

  static const _carouselTexts = <String>[
    "Optimize what works with Insights to know and\n understand your audience, allowing you fly high.",
    "Optimize what works with Insights to know and\n understand your audience, allowing you fly high.",
    "Optimize what works with Insights to\n know and understand your audience,\n allowing you fly high.",
  ];

  static const _backgroundColor = <Color>[
    ONBOARDING1,
    ONBOARDING2,
    ONBOARDING3,
  ];

  final CarouselController _carouselController = CarouselController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: _backgroundColor[_currentIndex],
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: height,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: SkipButton(
                        onTap: () {},
                      ),
                    ),
                    SizedBox(height: height * .01),
                    CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount: 3,
                      itemBuilder: (context, index, realIndex) =>
                          _CarouselImage(
                        image: _carouselImages[index],
                        title: _carouselTitles[index],
                        subTitle: _carouselTexts[index],
                        viewPortHeight: height,
                        slider: Container(
                          margin: EdgeInsets.only(
                            top: _currentIndex < _carouselImages.length - 1
                                ? 20
                                : 0,
                          ),
                          child: CarouselIndicator(
                            count: 3,
                            currentIndex: _currentIndex,
                          ),
                        ),
                      ),
                      options: CarouselOptions(
                        initialPage: 0,
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                        height: 0.85 * height <= 550 ? 0.75 * height : 700,
                        autoPlayInterval: Duration(seconds: 4),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.easeInOut,
                        onPageChanged: (newIndex, reason) => setState(() {
                          _currentIndex = newIndex;
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: height / 120,
              right: height / 50,
              left: height / 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(GetStartedScreen.routeName);
                      },
                      child: Image.asset(
                        "assets/images/get_started_button.png",
                        width: 80.w,
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          SignInScreen.routeName,
                        );
                      },
                      child: Image.asset(
                        "assets/images/login_button.png",
                        width: 80.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarouselImage extends StatelessWidget {
  final Key? key;
  final String image;
  final String title;
  final String subTitle;
  final Widget slider;
  final double viewPortHeight;

  _CarouselImage({
    this.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.viewPortHeight,
    required this.slider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/$image",
          height: viewPortHeight * .48,
          fit: BoxFit.contain,
        ),
        slider,
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20, bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: context.textTheme.bodyLarge!.copyWith(
              fontFamily: "LoveYaLikeASister",
              fontSize: 38,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin:
              EdgeInsets.only(bottom: 0.45 * viewPortHeight <= 350 ? 20 : 3),
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Text(subTitle,
              textAlign: TextAlign.center, style: context.textTheme.bodyLarge),
        ),
      ],
    );
  }
}
