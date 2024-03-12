import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constant.dart';
import '../utils/email_validator.dart';

class OurTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final IconButton? suffixIcon;
  final bool? isPassword;
  final bool? isEmail;
  final bool? isReadOnly;
  final int? maxLines;
  final TextInputType? keyboardType;
  const OurTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.suffixIcon,
    this.isPassword = false,
    this.isEmail = false,
    this.isReadOnly = false,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  State<OurTextField> createState() => _OurTextFieldState();
}

class _OurTextFieldState extends State<OurTextField> {
  bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.sp),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
          border: Border.all(
              color: AppColors.textAndOutlineBottom,
              width: 1.0
          )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
        child: TextFormField(
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          readOnly: widget.isReadOnly == true ? true : false,
          maxLines: widget.maxLines,
          style: GoogleFonts.urbanist(fontSize: 15.5.sp,
              // color: Colors.black87
              color: AppColors.textAndOutlineBottom,
            fontWeight: FontWeight.w500
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please fill this field';
            }
            if (!isValidEmail(value) && widget.isEmail == true) {
              return 'Please enter a valid email address.';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: _showPassword == true && widget.isPassword == true ? true : false,
          decoration: InputDecoration(
            filled: true,
            // fillColor:  AppColors.textFilledColor,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
              // borderSide: BorderSide(color: AppColors.textAndOutlineBottom, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
            ),

            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(12.sp),
            //   borderSide: BorderSide(color: Colors.black.withOpacity(0.3), width: 1.0),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(12.sp),
            //   borderSide: BorderSide(color: Colors.black.withOpacity(0.3), width: 1.0),
            // ),
            hintText: widget.hint,
            hintStyle: GoogleFonts.urbanist(fontSize: 15.5.sp,fontWeight: FontWeight.w600,color: AppColors.textAndOutlineColor.withOpacity(0.4)),
            errorStyle: const TextStyle(
              color: Colors.blue, // Change the color of the error text
            ),
            // labelText: widget.hint,
            // labelStyle: GoogleFonts.urbanist(
            //   fontSize: 16.sp,
            //   fontWeight: FontWeight.w500,
            //   color: Colors.black.withOpacity(0.65),
            // ),
            // hintStyle: GoogleFonts.urbanist(
            //   fontSize: 16.sp,
            //   fontWeight: FontWeight.w500,
            //   color: Colors.black.withOpacity(0.65),
            // ),
            contentPadding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 18.sp),
            suffixIcon: widget.isPassword == true
                ? IconButton(
                onPressed: () {
                  setState(() {
                    _showPassword == true ? _showPassword = false : _showPassword = true;
                  });
                },
                icon: Icon(
                  _showPassword == true ? Icons.visibility : Icons.visibility_off,
                  color: OurColor.highlightBG,
                ))
                : widget.suffixIcon,
          ),

        ),
      ),
    );
  }
}
