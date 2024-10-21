import 'package:flutter/material.dart';
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
        borderRadius: BorderRadius.circular(60),
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(
            color: BLACK.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 10,
      ),
      backgroundColor: BUTTONGREEN.withOpacity(0.1),
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(
            milliseconds: 003,
          ),
          curve: Curves.decelerate,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
        ),
      ),
      navBarStyle: NavBarStyle.style12,
    );
  }
}

List<Widget> _buidScreens() {
  return [
    HomeScreen(),
    const LinkScreen(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  const activeColorPrimary = Colors.black;
  const inactiveColorPrimary = Colors.grey;
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: 'Home',
      activeColorPrimary: activeColorPrimary,
      inactiveColorPrimary: inactiveColorPrimary,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.people),
      title: 'Ward',
      activeColorPrimary: activeColorPrimary,
      inactiveColorPrimary: inactiveColorPrimary,
    ),
  ];
}
