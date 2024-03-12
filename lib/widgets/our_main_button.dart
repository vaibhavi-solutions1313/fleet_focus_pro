import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constant.dart';

class OurMainButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  const OurMainButton({
    super.key,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.sp),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.9),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.sp),
              side: BorderSide(
                color: AppColors.textAndOutlineColor,
                width: 1.0,
              ),
            )),
        onPressed: onPress,
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.textAndOutlineTop, AppColors.textAndOutlineBottom],
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 16.sp),
          ),
        ),
      ),
    );
  }
}
