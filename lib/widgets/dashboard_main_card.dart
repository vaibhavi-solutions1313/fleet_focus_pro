import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constant.dart';

class DashboardMainCard extends StatelessWidget {
  final String title;
  final String value;
  final String trailingIcon;
  final Widget? leadingIcon;
  final Color? color;
  final VoidCallback? onTap;
  const DashboardMainCard({
    super.key,
    required this.title,
    required this.value,
    this.leadingIcon,
    this.onTap,
    this.color,this.trailingIcon='',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        // color: OurColors.cardBG,
        surfaceTintColor: Colors.white,
        color: Colors.white,
        elevation: 10,

        shadowColor: Colors.black26,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.5, 0.5),
                spreadRadius: 0.5,
                blurRadius: 3.5,
                color: AppColors.textFilledColor
              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (leadingIcon != null) leadingIcon!,
                          Text(
                             trailingIcon+value.toString().toString().padLeft(2,'0'),
                            style: GoogleFonts.lato(fontSize: 20.sp, fontWeight: FontWeight.w700, color: color),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          title,
                          style: GoogleFonts.lato(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Color(0xFF424040)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
