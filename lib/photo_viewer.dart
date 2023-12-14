import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'constant.dart';

class OurPhotoView extends StatefulWidget {
  final List<Map<String, String>> galleryImages;
  const OurPhotoView({super.key, required this.galleryImages});

  @override
  State<OurPhotoView> createState() => _OurPhotoViewState();
}

class _OurPhotoViewState extends State<OurPhotoView> {
  int indexForAppBar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.galleryImages[indexForAppBar]['label']!,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: PhotoViewGallery.builder(
        backgroundDecoration: const BoxDecoration(
          color: Colors.white,
        ),
        itemCount: widget.galleryImages.length,
        onPageChanged: (index) {
          setState(() {
            indexForAppBar = index;
          });
        },
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.galleryImages[index]['url']!),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            heroAttributes: PhotoViewHeroAttributes(tag: widget.galleryImages[index]['url']!),
          );
        },
      ),
    );
  }
}
