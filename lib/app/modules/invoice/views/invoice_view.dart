import 'package:fleet_focus_pro/app/modules/invoice/views/search_invoice_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_dropdown.dart';
import '../../../../widgets/our_dropdown_strings.dart';
import '../../../../widgets/our_main_button.dart';
import '../../../../widgets/our_text_field.dart';
import '../../customer/controllers/customer_controller.dart';
import '../controllers/invoice_controller.dart';

class InvoiceView extends GetView<InvoiceController> {
  const InvoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black54),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        title: Text(
          "Invoice",
          style: TextStyle(
              fontSize: 18.sp,
              color: Color(0xFF524C4C),
              letterSpacing: 0.2,
              fontWeight: FontWeight.w900),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // gradient: const LinearGradient(
                //   begin: Alignment.centerLeft,
                //   end: Alignment.centerRight,
                //   colors: <Color>[Color(0xFF12ADDD), Color(0xFF14598D)],
                // ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColors.splashDark, AppColors.splashLight],
                ),
              ),
              child: IconButton(
                onPressed: () {
                  Get.to(const SearchInvoiceView());
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
        children: [
          Text(
            "Create Invoice",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: 'Montserrat'),
          ),
          SizedBox(
            height: 10.sp,
          ),
          OurListStringDropDown(
            hintText: 'Select GST',
            dropdownItems: controller.gstOptions,
            onDropdownChanged: (value) {
              controller.selectedGst = value;
            },
          ),
          SizedBox(
            height: 10.sp,
          ),
          OurTextField(
              hint: 'Invoice Number', controller: controller.invoiceNumber),
          SizedBox(
            height: 10.sp,
          ),
          OurTextField(
            hint: 'Select Invoice Date',
            controller: controller.invoiceDate,
            suffixIcon: IconButton(
              onPressed: () {
                controller.selectDOB(false).then((value) {
                  controller.invoiceDate.text = value;
                });
              },
              icon: const Icon(
                Icons.calendar_month,
                // color: Colors.black54,
                color: AppColors.textAndOutlineColor,
              ),
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          OurTextField(
              hint: 'Invoice Remarks', controller: controller.invoiceRemarks),
          SizedBox(
            height: 10.sp,
          ),
          OurListObjectDropDown(
              dropdownItems: Get.find<CustomerController>().customersLists,
              onDropdownChanged: (value) {
                controller.selectedCustomerId = value['id'].toString();
              },
              keyName: 'name'),
          SizedBox(
            height: 12.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Additionally",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
                TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: Adaptive.h(50),
                            child:
                                StatefulBuilder(builder: (context, setState) {
                              return Material(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ShaderMask(
                                            blendMode: BlendMode.srcIn,
                                            shaderCallback: (bounds) =>
                                                LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                AppColors.textAndOutlineTop,
                                                AppColors.textAndOutlineBottom
                                              ],
                                            ).createShader(Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    bounds.width,
                                                    bounds.height)),
                                            child: Text(
                                              'Invoice Details',
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: ShaderMask(
                                              blendMode: BlendMode.srcIn,
                                              shaderCallback: (bounds) =>
                                                  LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  AppColors.textAndOutlineTop,
                                                  AppColors.textAndOutlineBottom
                                                ],
                                              ).createShader(Rect.fromLTWH(
                                                      0,
                                                      0,
                                                      bounds.width,
                                                      bounds.height)),
                                              child: Icon(
                                                Icons.cancel,
                                                color: Colors.black
                                                    .withOpacity(0.65),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Obx(() => controller
                                              .selectedAmountDescription
                                              .isNotEmpty
                                          ? Column(
                                              children: [
                                                Expanded(
                                                  child: ListView(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 18),
                                                    children: List.generate(
                                                      controller
                                                          .selectedAmountDescription
                                                          .length,
                                                      (index) => Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      "${index + 1}.",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              AppColors.textAndOutlineBottom),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.stretch,
                                                                        children: [
                                                                          ShaderMask(
                                                                            shaderCallback: (bounds) => LinearGradient(
                                                                              begin: Alignment.topCenter,
                                                                              end: Alignment.bottomCenter,
                                                                              colors: [AppColors.textAndOutlineTop, AppColors.textAndOutlineBottom],
                                                                            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                                                                            child: RichText(
                                                                              text:
                                                                                  TextSpan(text: 'Amount: ', style: TextStyle(fontSize: 15.sp), children: <TextSpan>[
                                                                                TextSpan(text: '${controller.selectedAmountDescription[index]['amount']}', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal))
                                                                              ]),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                              'Description: ${controller.selectedAmountDescription[index]['description']}',
                                                                              style: TextStyle(fontSize: 15.sp, color: AppColors.textAndOutlineBottom)),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  controller
                                                                      .selectedAmountDescription
                                                                      .removeAt(
                                                                          index);
                                                                  controller
                                                                      .subtotal
                                                                      .value = 0.0;
                                                                  controller
                                                                      .selectedAmountDescription
                                                                      .forEach(
                                                                          (element) {
                                                                    controller
                                                                        .subtotal
                                                                        .value = double.parse(element[
                                                                            'amount']) +
                                                                        controller
                                                                            .subtotal
                                                                            .value;
                                                                    controller
                                                                        .gst
                                                                        .value = controller
                                                                            .subtotal
                                                                            .value /
                                                                        10;
                                                                    controller
                                                                        .totalAmount
                                                                        .value = controller
                                                                            .gst
                                                                            .value +
                                                                        controller
                                                                            .subtotal
                                                                            .value;
                                                                  });
                                                                },
                                                                child: const Text(
                                                                    "Remove"),
                                                              ),
                                                            ],
                                                          ),
                                                          index !=
                                                                  controller
                                                                          .selectedAmountDescription
                                                                          .length -
                                                                      1
                                                              ? Divider()
                                                              : Row()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15.0.sp,
                                                      vertical: 10.sp),
                                                  child: Obx(() => Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Sub Total",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.sp, color: AppColors.textAndOutlineTop),
                                                              ),
                                                              Text(
                                                                controller
                                                                    .subtotal
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.sp, color: AppColors.textAndOutlineTop),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "GST",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.sp, color: AppColors.textAndOutlineTop),
                                                              ),
                                                              Text(
                                                                controller.gst
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.sp, color: AppColors.textAndOutlineTop),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Total",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.sp, color: AppColors.textAndOutlineTop),
                                                              ),
                                                              Text(
                                                                controller
                                                                    .totalAmount
                                                                    .value
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.sp, color: AppColors.textAndOutlineTop),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ],
                                            )
                                          : const Center(
                                              child: Text(
                                                  "No Invoice Detail Selected...", style: TextStyle(color: AppColors.textAndOutlineTop, fontWeight: FontWeight.w500),))),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          );
                        },
                      );
                    },
                    child: Obx(() => Text(
                        "Added List (${controller.selectedAmountDescription.length})"))),
              ],
            ),
          ),
          Form(
            key: controller.amountDescForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OurTextField(
                    hint: 'Amount',
                    controller: controller.amount,
                    keyboardType: TextInputType.number),
                SizedBox(
                  height: 10.sp,
                ),
                OurTextField(
                    hint: 'Description', controller: controller.description),
                SizedBox(
                  height: 20.sp,
                ),
                OurMainButton(
                  title: 'Add',
                  onPress: () {
                    if (controller.amountDescForm.currentState!.validate()) {
                      controller.selectedAmountDescription.add({
                        "amount": controller.amount.text,
                        "description": controller.description.text
                      });
                      controller.selectedAmountDescription.forEach((element) {
                        controller.subtotal.value =
                            double.parse(element['amount']) +
                                controller.subtotal.value;
                        controller.gst.value = controller.subtotal.value / 10;
                        controller.totalAmount.value =
                            controller.gst.value + controller.subtotal.value;
                      });
                      controller.amount.clear();
                      controller.description.clear();
                      HelpingMethods.showToast('Added to List');
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.sp,
          ),
          OurButton(
              onTap: () {
                if (controller.selectedAmountDescription.isNotEmpty) {
                  context.loaderOverlay.show();
                  controller.generateInvoice().then((value) {
                    controller.clearTextFields();
                    context.loaderOverlay.hide();
                  }).onError((error, stackTrace) {
                    context.loaderOverlay.hide();
                    HelpingMethods.showToast(error.toString());
                  });
                } else {
                  HelpingMethods.showToast(
                      'Please add at least one amount, description.');
                }
              },
              title: "Generate Invoice")
        ],
      ),
    );
  }
}
