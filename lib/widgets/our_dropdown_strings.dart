import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constant.dart';

class OurListStringDropDown extends StatefulWidget {
  final String hintText;
  final List<dynamic> dropdownItems;
  final dynamic selectedDropdownItem;
  final ValueChanged<dynamic> onDropdownChanged;
  const OurListStringDropDown({super.key, required this.dropdownItems, this.selectedDropdownItem, required this.onDropdownChanged, this.hintText = "Select"});

  @override
  State<OurListStringDropDown> createState() => _OurListStringDropDownState();
}

class _OurListStringDropDownState extends State<OurListStringDropDown> {
  dynamic _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedDropdownItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.sp),
      decoration: BoxDecoration(
          // color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12.sp),
          border: Border.all(color: Colors.black26,width: 1.3)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<dynamic>(
              hint: Text(
                widget.hintText,
                style: GoogleFonts.urbanist(fontSize: 16.sp, color: Colors.black.withOpacity(0.65),fontWeight: FontWeight.w500),
              ),
              value: _selectedItem,
              onChanged: (dynamic newValue) {
                setState(() {
                  _selectedItem = newValue;
                });
                widget.onDropdownChanged(newValue); // Notify parent about the change
              },
              underline: const SizedBox(),
              isExpanded: true,
              dropdownColor: OurColor.scaffoldBG,
              style: GoogleFonts.urbanist(fontSize: 16.sp, color: Colors.black54,fontWeight: FontWeight.w600),
              items: widget.dropdownItems.map((dynamic item) {
                return DropdownMenuItem<dynamic>(
                  value: item,
                  child: Text(item.toString(),style: TextStyle(fontSize: 16.sp, color: Colors.black54),),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
