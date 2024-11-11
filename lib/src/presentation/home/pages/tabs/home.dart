import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/src/shared/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50.withOpacity(0.5),
      appBar: CustomAppBar(
        title: 'Dashboard',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: BLACK.withOpacity(0.1),
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _ProfileRow(),
                    AppSpacing.verticalSpaceSmall,
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue.shade50,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                    AppSpacing.verticalSpaceSmall,
                    Text(
                      'John Doe',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: BLACK,
                            fontWeight: FontWeight.normal,
                            fontSize: 32.sp,
                          ),
                    ),
                    AppSpacing.verticalSpaceTiny,
                    Text(
                      'CEO, RootsCards',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: GREY,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    AppSpacing.verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Links',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: BLACK,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Contacts',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: BLACK,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            AppSpacing.horizontalSpaceSmall,
                            FlutterSwitch(
                              value: false,
                              onToggle: (val) {
                                print(val);
                              },
                              activeColor: BUTTONGREEN,
                              activeToggleColor: Colors.white,
                              height: 27,
                              width: 45,
                              inactiveColor: Colors.grey,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Business',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: BLACK, fontWeight: FontWeight.w500, fontSize: 16.sp),
            ),
            Text(
              'Profile',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: GREY, fontWeight: FontWeight.w500, fontSize: 12.sp),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '36+',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: BLACK,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ),
            ),
            Text(
              'Connected',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: GREY, fontWeight: FontWeight.w500, fontSize: 12.sp),
            ),
          ],
        ),
      ],
    );
  }
}
