import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constant.dart';

class OurButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isDelete;
  final String title;
  const OurButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.sp),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              // begin: Alignment.centerLeft,
              // end: Alignment.centerRight,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [AppColors.splashDark, AppColors.splashLight],
              // colors: <Color>[Color(0xFF12ADDD), Color(0xFF14598D)],
            ),
          ),
          // style: ElevatedButton.styleFrom(backgroundColor: isDelete ? Colors.red :OurColor.highlightBG, padding: EdgeInsets.symmetric(vertical: 14.sp, horizontal: 15.sp)),
          // onPressed: onTap,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16.sp,
                  letterSpacing: 0.5,
                  // color: Colors.white,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
