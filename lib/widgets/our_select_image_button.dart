import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constant.dart';

class SelectImageButton extends StatelessWidget {
  final String? title;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const SelectImageButton({
    super.key,
    this.title,
    required this.label,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.sp),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.sp),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.5, 0.5),
                  spreadRadius: 0.8,
                  blurRadius: 2,
                  color: Colors.grey.shade200
              )
            ]
        ),
        child: Padding(
          padding: EdgeInsets.symmetric( horizontal: 18.0.sp,vertical: 15.sp),
          child: Row(
            children: [
              Text(
                title ?? label,
                style: GoogleFonts.lato(fontSize: 16.sp, color: Colors.black.withOpacity(0.54), fontWeight: FontWeight.w500),
              ),
              if (isSelected == true)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 16.sp,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
