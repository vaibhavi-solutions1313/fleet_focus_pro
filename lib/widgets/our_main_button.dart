import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.85), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp))),
      onPressed: onPress,
      child: Text(
        title,
        style: TextStyle(color: Colors.black87, fontSize: 16.sp),
      ),
    );
  }
}
