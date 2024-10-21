import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/src/presentation/screens/interests/models/interest_list.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  static const String routeName = "Interest_screen";

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

List<Map<String, dynamic>> selectedInterests = [];

class _InterestScreenState extends State<InterestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20.h,
               
              ),
          child: Column(
            children: [
              Text(
                'Select Topic That Interests You',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 32.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
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
                child: GridView.builder(
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
            ],
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
                color: isSelected ? Colors.grey : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey, width: 1),
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