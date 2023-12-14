import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constant.dart';

class OurAppBar extends StatelessWidget {
  final String title;
  const OurAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(50.sp),
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(50.sp)),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black54,
                size: 21.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.sp),
            child: Text(
              title,
              style: TextStyle(fontSize: 18.sp, color: Color(0xFF524C4C), letterSpacing: 0.2, fontWeight: FontWeight.w900),
            ),
          )
        ],
      ),
    );
  }
}
