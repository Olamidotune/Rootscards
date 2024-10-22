import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/src/presentation/screens/interests/models/interest_list.dart';
import 'package:rootscards/src/shared/widgets/button.dart';
import 'package:rootscards/src/shared/widgets/grey_button.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  static const String routeName = "Interest_screen";

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

List<Map<String, dynamic>> selectedInterests = [];
List<String> selectedCreativeCategories = [];
ScrollController _scrollController = ScrollController();
bool busy = false;

class _InterestScreenState extends State<InterestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
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
                SizedBox(
                  height: .3.sh,
                  child: GridView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: interestList.length,
                    itemBuilder: (context, index) {
                      final interest = interestList[index];
                      return InterestsWidget(
                        onTap: () => _toggleInterest(interest),
                        text: interest['name'],
                        emoji: interest['emoji'],
                        isSelected: selectedInterests.contains(interest),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2,
                      mainAxisSpacing: 7.h,
                      crossAxisSpacing: 7.w,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height <
                          MIN_SUPPORTED_SCREEN_HEIGHT
                      ? 0.1.sh
                      : 0.16.sh,
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'Pick your Creative category (Optional)',
                //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //           color: BLACK,
                //           fontWeight: FontWeight.w100,
                //           fontSize: 14.sp,
                //         ),
                //     textAlign: TextAlign.justify,
                //   ),
                // ),
                // AppSpacing.verticalSpaceMedium,
                // SizedBox(
                //   height: .3.sh,
                //   child: GridView.builder(
                //     controller: _scrollController,
                //     shrinkWrap: true,
                //     itemCount: creativeCategories.length,
                //     itemBuilder: (context, index) {
                //       final creativeCategory = creativeCategories[index];
                //       return CreativeCategoriesWidget(
                //         onTap: () => _toggleCreativeCat(creativeCategory),
                //         text: creativeCategory,
                //         isSelected: selectedCreativeCategories
                //             .contains(creativeCategory),
                //       );
                //     },
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 3,
                //       childAspectRatio: 2,
                //       mainAxisSpacing: 7.h,
                //       crossAxisSpacing: 7.w,
                //     ),
                //   ),
                // ),
                AppSpacing.verticalSpaceMedium,
                Button('Continue', busy: busy, pill: true, onPressed: () {
                  setState(() {
                    busy = true;
                  });
                  Timer(Duration(seconds: 3), () {
                    _saveSelectedInterests();
                    Navigator.of(context).pushNamed(InterestScreen.routeName);
                    setState(() {
                      busy = false;
                    });
                  });
                }),
                AppSpacing.verticalSpaceSmall,
                GreyButton(
                  'Skip',
                  pill: true,
                  color: GREY,
                  onPressed: () {
                    Timer(Duration(seconds: 3), () {
                      Navigator.of(context).pushNamed(InterestScreen.routeName);
                    });
                  },
                ),
                AppSpacing.verticalSpaceMedium,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleInterest(Map<String, dynamic> interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
      }
    });
    _saveSelectedInterests();
  }

  void _saveSelectedInterests() {}

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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: .25.sw,
              height: .05.sh,
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border:
                    Border.all(color: Colors.grey.withOpacity(.4), width: 1),
              ),
              child: GestureDetector(
                onTap: () {
                  onTap();
                  print(isSelected);
                },
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
            ),
          ],
        )
      ],
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: .25.sw,
              height: .05.sh,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.grey.withOpacity(.7)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border:
                    Border.all(color: Colors.grey.withOpacity(.4), width: 1),
              ),
              child: GestureDetector(
                onTap: () {
                  onTap();
                  print(isSelected);
                },
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
            ),
          ],
        )
      ],
    );
  }
}







// class InterestPickerScreen extends StatefulWidget {
//   @override
//   _InterestPickerScreenState createState() => _InterestPickerScreenState();
// }

// class _InterestPickerScreenState extends State<InterestPickerScreen> {
//   List<Map<String, dynamic>> selectedInterests = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadSelectedInterests();
//   }

//   Future<void> _loadSelectedInterests() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> savedInterests = prefs.getStringList('selectedInterests') ?? [];

//     setState(() {
//       selectedInterests = savedInterests
//           .map((interest) => interestList.firstWhere((item) => item['name'] == interest))
//           .toList();
//     });
//   }

//   void _toggleInterest(Map<String, dynamic> interest) {
//     setState(() {
//       if (selectedInterests.contains(interest)) {
//         selectedInterests.remove(interest);
//       } else {
//         selectedInterests.add(interest);
//       }
//     });
//     _saveSelectedInterests();
//   }

//   Future<void> _saveSelectedInterests() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList(
//       'selectedInterests',
//       selectedInterests.map((interest) => interest['name']).toList(),
//     );
//   }

 
// }