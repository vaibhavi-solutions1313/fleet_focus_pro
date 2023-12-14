import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../app/modules/invoice/controllers/invoice_controller.dart';
import '../constant.dart';

class OurPDFView extends StatefulWidget {
  final String url;
  const OurPDFView({super.key, required this.url});

  @override
  State<OurPDFView> createState() => _OurPDFViewState();
}

class _OurPDFViewState extends State<OurPDFView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Generated PDF",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.find<InvoiceController>().launchURL(widget.url);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: PDF().cachedFromUrl(
        widget.url,
        placeholder: (progress) => Center(
            child: Text(
          '$progress %',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        )),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
