import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_pdf_view.dart';
import '../../../../widgets/our_text_field.dart';
import '../controllers/invoice_controller.dart';

class SearchInvoiceView extends StatefulWidget {
  const SearchInvoiceView({super.key});

  @override
  State<SearchInvoiceView> createState() => _SearchInvoiceViewState();
}

class _SearchInvoiceViewState extends State<SearchInvoiceView> {
  final controller = Get.find<InvoiceController>();

  @override
  void initState() {
    controller.searchInvoiceResult.clear();
    controller.invoiceFromDate.clear();
    controller.invoiceToDate.clear();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black54),
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_new)),
        title: Text(
          "Search Invoice",
          style: TextStyle(fontSize: 18.sp, color: Color(0xFF524C4C), letterSpacing: 0.2, fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
        children: [
          OurTextField(
            hint: 'Select Invoice From Date',
            controller: controller.invoiceFromDate,
            suffixIcon: IconButton(
              onPressed: () {
                controller.selectDOB(true).then((value) {
                  controller.invoiceFromDate.text = value;
                });
              },
              icon: const Icon(
                Icons.calendar_month,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            height: 12.sp,
          ),
          OurTextField(
            hint: 'Select Invoice to Date',
            controller: controller.invoiceToDate,
            suffixIcon: IconButton(
              onPressed: () {
                controller.selectDOB(true).then((value) {
                  controller.invoiceToDate.text = value;
                });
              },
              icon: const Icon(
                Icons.calendar_month,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            height: 12.sp,
          ),
          OurButton(
              onTap: () {
                controller.searchInvoiceResult.clear();
                if (controller.invoiceFromDate.text.isNotEmpty && controller.invoiceToDate.text.isNotEmpty) {
                  context.loaderOverlay.show();
                  controller.searchInvoices().then((value) {
                    context.loaderOverlay.hide();
                  }).onError((error, stackTrace) {
                    context.loaderOverlay.hide();
                    HelpingMethods.showToast(error.toString());
                  });
                } else {
                  HelpingMethods.showToast('Please fill dates first');
                }
              },
              title: 'Find Invoices'),
          SizedBox(
            height: 12.sp,
          ),
          Obx(() => controller.searchInvoiceResult.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    controller.searchInvoiceResult.length,
                    (index) => ListTile(
                      title: Text(
                        controller.searchInvoiceResult[index]['name'],
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      subtitle: Text(
                        controller.searchInvoiceResult[index]['invoice_date'],
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      trailing: TextButton(
                          onPressed: () {
                            context.loaderOverlay.show();
                            controller.getInvoicePdf(controller.searchInvoiceResult[index]['id'].toString()).then((value) {
                              context.loaderOverlay.hide();
                              if (value.statusCode == 200) {
                                Get.to(OurPDFView(url: value.data['data']), transition: Transition.rightToLeft);
                              }
                            }).onError((error, stackTrace) {
                              context.loaderOverlay.hide();
                            });
                          },
                          child: const Text("View Invoice")),
                    ),
                  ),
                )
              : const Center(child: Text("Nothing found!"))),
        ],
      ),
    );
  }
}
