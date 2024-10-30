import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/src/presentation/screens/interests/models/interest_list.dart';
import 'package:rootscards/src/presentation/screens/space/space_screen.dart';
import 'package:rootscards/src/shared/widgets/button.dart';
import 'package:rootscards/src/shared/widgets/custom_snackbar.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  static const String routeName = "Interest_screen";

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

ScrollController _scrollController = ScrollController();
bool busy = false;
List<dynamic> interests = interest['interests'];
Set<int> selectedValues = {};
List<String> selectedCreativeCategories = [];
int? selectedInterestIndex;

class _InterestScreenState extends State<InterestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Interests',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Topic\nThat Interests You',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'DarkerGrotesque',
                          fontSize: 32.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
                Text(
                  'Choose from a diverse range of interests that align with your passions and preferences.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: GREY,
                        fontWeight: FontWeight.w100,
                        fontSize: 14.sp,
                      ),
                  textAlign: TextAlign.justify,
                ),
                AppSpacing.verticalSpaceMedium,
                GridView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: interests.length,
                  itemBuilder: (context, index) {
                    final interestItem = interests[index];
                    return InterestsWidget(
                      onTap: () => _toggleSelectedValue(index),
                      text: interestItem['name'],
                      emoji: interestItem['emoji'],
                      isSelected: selectedValues.contains(index),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2,
                    mainAxisSpacing: 7.h,
                    crossAxisSpacing: 7.w,
                  ),
                ),
                if (selectedValues.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pick your Creative category (Optional)',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: BLACK,
                            fontWeight: FontWeight.w100,
                            fontSize: 16.sp,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  AppSpacing.verticalSpaceMedium,
                  GridView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: getSelectedCategories().length,
                    itemBuilder: (context, index) {
                      final creativeCategory = getSelectedCategories()[index];
                      return CreativeCategoriesWidget(
                        onTap: () => _toggleCreativeCat(creativeCategory),
                        text: creativeCategory,
                        isSelected: selectedCreativeCategories
                            .contains(creativeCategory),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2,
                      mainAxisSpacing: 7.h,
                      crossAxisSpacing: 7.w,
                    ),
                  ),
                ],
                AppSpacing.verticalSpaceMedium,
                Button(
                  'Continue',
                  busy: busy,
                  pill: true,
                  onPressed: () {
                    if (selectedValues.isEmpty) {
                      CustomSnackbar.show(
                        context,
                        'Please select at least one interest',
                        isError: true,
                      );
                      return;
                    }
                    setState(() {
                      busy = true;
                    });
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        busy = false;
                      });
                      CustomSnackbar.show(
                        context,
                        'Interests saved successfully',
                        isError: false,
                      );
                      Navigator.of(context).pushNamed(SpaceScreen.routeName);
                    });
                  },
                ),
                AppSpacing.verticalSpaceSmall,
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Toggle selection for interests
  void _toggleSelectedValue(int index) {
    setState(() {
      if (selectedValues.contains(index)) {
        selectedValues.remove(index);
      } else {
        selectedValues.add(index);
      }
    });
  }

  // Gather unique categories from all selected interests
  List<String> getSelectedCategories() {
    final categories = <String>{}; // Using a Set to avoid duplicates
    for (var index in selectedValues) {
      categories.addAll(interests[index]['categories']);
    }
    return categories.toList();
  }

  _toggleCreativeCat(String creativeCategory) {
    setState(() {
      if (selectedCreativeCategories.contains(creativeCategory)) {
        selectedCreativeCategories.remove(creativeCategory);
      } else {
        selectedCreativeCategories.add(creativeCategory);
      }
    });
    _saveSelectedCreativeCategories();
  }

  void _saveSelectedCreativeCategories() {}
}

class CreativeCategoriesWidget extends StatelessWidget {
  final Function() onTap;
  final String text;
  final bool isSelected;
  const CreativeCategoriesWidget(
      {super.key,
      required this.onTap,
      required this.text,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
        print(isSelected);
      },
      child: Container(
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        width: .25.sw,
        height: .05.sh,
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.withOpacity(.4), width: 1),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

class InterestsWidget extends StatelessWidget {
  final Function() onTap;
  final String text;
  final String emoji;
  final bool isSelected;
  const InterestsWidget({
    super.key,
    required this.onTap,
    required this.text,
    required this.emoji,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
        print(isSelected);
      },
      child: Container(
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        width: .25.sw,
        height: .05.sh,
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.withOpacity(.7) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.withOpacity(.4), width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                emoji,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 16,
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
