import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_dropdown.dart';
import '../../../../widgets/our_text_field.dart';
import '../../license_type/controllers/license_type_controller.dart';
import '../controllers/truck_controller.dart';

class TruckTypesView extends StatefulWidget {
  const TruckTypesView({super.key});

  @override
  State<TruckTypesView> createState() => _TruckTypesViewState();
}

class _TruckTypesViewState extends State<TruckTypesView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TruckController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: Text(
          "Vehicle Types",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFF12ADDD),
                  Color(0xFF14598D)
                ],
              ),
            ),
            child: IconButton(
              onPressed: () {
                final _formKey = GlobalKey<FormState>();
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Create Vehicle Type",
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Text(
                            "Please fill the information below",
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          OurTextField(hint: "Vehicle Type", controller: controller.vehicleType),
                          SizedBox(
                            height: 10.sp,
                          ),
                          OurListObjectDropDown(
                              selectedDropdownItem: controller.selectedLicense,
                              hintText: "Select License",
                              dropdownItems: Get.find<LicenseTypeController>().licenceTypes.value,
                              onDropdownChanged: (value) {
                                controller.selectedLicense = value;
                              },
                              keyName: "type"),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: OurButton(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.loaderOverlay.show();
                                    controller.addVehicleType().then((value) {
                                      context.loaderOverlay.hide();
                                      Get.back();
                                      controller.vehicleType.clear();
                                    }).onError((error, stackTrace) {
                                      HelpingMethods.showToast(error.toString());
                                      context.loaderOverlay.hide();
                                      controller.vehicleType.clear();
                                    });
                                  }
                                },
                                title: 'Create'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).whenComplete(() {
                  controller.vehicleType.clear();
                  controller.selectedLicense = null;
                });
              },
              icon: const Icon(Icons.add,color: Colors.white,),
            ),
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Expanded(
                child: DataTable(
                  dataRowColor: MaterialStateProperty.all<Color>(Colors.grey.shade100),
                  headingRowColor: MaterialStateProperty.all<Color>(OurColor.highlightBG),
                  border: TableBorder(borderRadius: BorderRadius.circular(12.sp)),
                  columnSpacing: 2,
                  columns: [
                    DataColumn(
                      label: Text(
                        'Type',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'License Type',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                  ],
                  rows: controller.vehicleTypes.value.map((row) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            row['vehicle_type'].toString(),
                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.75), fontSize: 14.5.sp),
                          ),
                        ),
                        DataCell(
                          Text(
                            controller.findLicenseType(row['license_type']),
                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.75), fontSize: 14.5.sp),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              )),
        ],
      ),
    );
  }
}
