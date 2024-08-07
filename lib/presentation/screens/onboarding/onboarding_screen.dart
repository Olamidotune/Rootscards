import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/get_started_screen.dart';
import 'package:rootscards/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:rootscards/presentation/screens/widgets/carousel_inidicator.dart';
import 'package:rootscards/presentation/screens/widgets/get_started_button.dart';
import 'package:rootscards/presentation/screens/widgets/login_button.dart';
import 'package:rootscards/presentation/screens/widgets/skip_button.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "onboarding_screen";
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
    "Optimize what works with Insights to know and understand your audience, allowing you fly high.",
    "Optimize what works with Insights to know and understand your audience, allowing you fly high.",
    "Optimize what works with Insights to know and understand your audience, allowing you fly high.",
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
        child: SizedBox(
          height: height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SkipButton(
                    onTap: () => Navigator.of(context).pushNamed(
                      GetStartedScreen.routeName,
                    ),
                  ),
                ),
                AppSpacing.verticalSpaceSmall,
                Expanded(
                  flex: 10,
                  child: CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: 3,
                    itemBuilder: (context, index, realIndex) => _CarouselImage(
                      image: _carouselImages[index],
                      title: _carouselTitles[index],
                      subTitle: _carouselTexts[index],
                      viewPortHeight: height,
                      slider: Container(
                        margin: EdgeInsets.only(
                          top: _currentIndex < _carouselImages.length - 1
                              ? .06.sh
                              : 0,
                        ),
                        child: CarouselIndicator(
                          count: 3,
                          currentIndex: _currentIndex,
                        ),
                      ),
                      portView: .43.sh,
                    ),
                    options: CarouselOptions(
                      initialPage: 0,
                      autoPlay: false,
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                      height: .85.sh,
                      autoPlayCurve: Curves.easeInOut,
                      onPageChanged: (newIndex, reason) => setState(
                        () => _currentIndex = newIndex,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GetStartedButton(
                    onTap: () => Navigator.of(context)
                        .pushNamed(GetStartedScreen.routeName),
                  ),
                ),
                AppSpacing.verticalSpaceSmall,
                Expanded(
                  flex: 1,
                  child: LoginButton(
                    onTap: () =>
                        Navigator.of(context).pushNamed(SignInScreen.routeName),
                    textColor: BLACK,
                  ),
                ),
                AppSpacing.verticalSpaceMedium
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CarouselImage extends StatelessWidget {
  final Key? key;
  final String image;
  final double portView;
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
    required this.portView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Image.asset(
            "assets/images/$image",
            height: portView,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          slider,
          Text(
            title,
            style: context.textTheme.bodyLarge!.copyWith(
              fontFamily: "LoveYaLikeASister",
              fontSize: 30.sp,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalSpaceTiny,
          Text(
            subTitle,
            // textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
