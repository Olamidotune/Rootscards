
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rootscards/config/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.profileImage,
  });

  final String? title;
  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: CircleAvatar(
            radius: 20.w,
            backgroundColor: GREY,
            child: profileImage != null
                ? SvgPicture.asset(
                    profileImage!,
                  )
                : Text(
                    title!.substring(0, 1).toUpperCase(),
                  )),
      ),
      title: Text(title ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              )),
      actions: [
        GestureDetector(
          child: SvgPicture.asset(
            'assets/svg/search.svg',
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_sharp),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
