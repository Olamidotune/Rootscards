import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/src/presentation/home/pages/tabs/home.dart';
import 'package:rootscards/src/presentation/home/pages/tabs/link.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  static const String routeName = 'dashboard';

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;

    controller = PersistentTabController();
    return PersistentTabView(
      context,
      screens: _buidScreens(),
      controller: controller,
      items: _navBarsItems(),
      resizeToAvoidBottomInset: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(1),
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(
            color: BLACK.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(
            milliseconds: 200,
          ),
          curve: Curves.decelerate,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
        ),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}

List<Widget> _buidScreens() {
  return [
    HomeScreen(),
    const LinkScreen(),
    HomeScreen(),
    const LinkScreen(),
    const LinkScreen(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  const activeColorPrimary = BUTTONGREEN;
  const inactiveColorPrimary = Colors.grey;
  const activeColorSecondary = Colors.black;
  const textStyle = TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  return [
    PersistentBottomNavBarItem(
      icon: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          'assets/svg/home.svg',
        ),
      ),
      title: 'home',
      textStyle: textStyle,
      activeColorPrimary: activeColorPrimary.withOpacity(0.9),
      activeColorSecondary: activeColorSecondary,
      inactiveColorPrimary: inactiveColorPrimary,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        'assets/svg/links.svg',
      ),
      title: 'Links',
      activeColorPrimary: activeColorPrimary,
      inactiveColorPrimary: inactiveColorPrimary,
      activeColorSecondary: activeColorSecondary,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        'assets/svg/screen.svg',
      ),
      title: 'home',
      activeColorPrimary: activeColorPrimary,
      inactiveColorPrimary: inactiveColorPrimary,
      activeColorSecondary: activeColorSecondary,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        'assets/svg/cart.svg',
      ),
      title: 'Home',
      activeColorPrimary: activeColorPrimary,
      inactiveColorPrimary: inactiveColorPrimary,
      activeColorSecondary: activeColorSecondary,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        'assets/svg/settings.svg',
      ),
      title: 'Home',
      activeColorPrimary: activeColorPrimary,
      inactiveColorPrimary: inactiveColorPrimary,
      activeColorSecondary: activeColorSecondary,
    ),
  ];
}
