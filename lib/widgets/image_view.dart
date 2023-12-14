import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constant.dart';

class ImageView extends StatelessWidget {
  final String path;
  const ImageView({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: OurColors.cardBG,
        title: Text("Photo View",style: TextStyle(color: Colors.white,fontSize: 16.sp),),
      ),
      body: PhotoView(
        backgroundDecoration: BoxDecoration(
          color: Colors.white
        ),
        imageProvider: NetworkImage(path),
      ),
    );
  }
}
