import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:signature/signature.dart';

import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../photo_viewer.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_dropdown.dart';
import '../../../../widgets/our_dropdown_strings.dart';
import '../../../../widgets/our_select_image_button.dart';
import '../../../../widgets/our_text_field.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/driver_controller.dart';

class CreateDriverView extends StatefulWidget {
  final bool? isEdit;
  final bool? isReadByDefault;
  final dynamic editData;
  const CreateDriverView({super.key, this.isEdit = false, this.isReadByDefault = false, this.editData});

  @override
  State<CreateDriverView> createState() => _CreateDriverViewState();
}

class _CreateDriverViewState extends State<CreateDriverView> {
  var controller = Get.find<DriverController>();
  List<Map<String, String>> photoList = [];
  @override
  void initState() {
    if (widget.isEdit == true) {
      controller.fullName.text = widget.editData['user_name'] ?? "";
      controller.email.text = widget.editData['user_email'] ?? "";
      controller.address.text = widget.editData['address'] ?? "";
      controller.age.text = (widget.editData['age'] ?? "").toString();
      controller.selectedDOB.text = widget.editData['dob'] ?? "";
      controller.mobileNumber.text = widget.editData['mobile_number'] ?? "";
      controller.passportNumber.text = widget.editData['passport_number'] ?? "";
      controller.bankAccNumber.text = widget.editData['bank_account_number'] ?? "";
      controller.bankBsb.text = widget.editData['bank_bsb'] ?? "";
      controller.workingHours.text = (widget.editData['hours_allowed_to_work'] ?? "").toString();
      controller.abn.text = widget.editData['abnumber'] ?? "";
      controller.licenseNumber.text = widget.editData['license_number'] ?? "";
      controller.wage.text = (widget.editData['wages'] ?? "").toString();
      controller.passportCountry.text = widget.editData['passport_country'] ?? "";
      controller.refCode.text = widget.editData['ref_code'] ?? "";
      controller.visaFromDate.text = widget.editData['visa_start_date'] ?? "";
      controller.visaToDate.text = widget.editData['visa_end_date'] ?? "";

      if (widget.editData['is_active'] == 1) {
        controller.isUserActive.value = true;
      } else {
        controller.isUserActive.value = false;
      }
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.resetValues();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: Text(
          widget.isEdit == false ? "Create Driver" : "Driver Details & Update",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisSize: MainAxisSize.min,
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 12.sp),
        children: [
          Form(
            key: controller.formLogin,
            child: Column(
              // physics: const BouncingScrollPhysics(),
              // padding: EdgeInsets.symmetric(vertical: 10.sp),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0.sp),
                  child: Text(
                    "Basic Information",
                    style: TextStyle(color: Colors.black.withOpacity(0.75), fontWeight: FontWeight.w500, fontSize: 15.sp),
                  ),
                ),
                OurTextField(hint: 'Full Name', controller: controller.fullName),
                SizedBox(
                  height: 10.sp,
                ),
                OurTextField(hint: 'Email', controller: controller.email, isEmail: true, keyboardType: TextInputType.emailAddress),
                SizedBox(
                  height: 10.sp,
                ),
                OurTextField(hint: 'Password', controller: controller.password, isPassword: true),
                SizedBox(
                  height: 10.sp,
                ),
                OurTextField(hint: 'Address', controller: controller.address),
                SizedBox(
                  height: 10.sp,
                ),
                OurTextField(hint: 'Age', controller: controller.age, keyboardType: TextInputType.number),
                SizedBox(
                  height: 10.sp,
                ),
                OurTextField(hint: 'Mobile Number', controller: controller.mobileNumber, keyboardType: TextInputType.number),
                SizedBox(
                  height: 12.sp,
                ),
                OurTextField(
                  hint: 'Select Date of Birth',
                  controller: controller.selectedDOB,
                  isReadOnly: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.selectDOB(true).then((value) {
                        controller.selectedDOB.text = value;
                      });
                    },
                    icon: const Icon(
                      Icons.date_range,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                OurTextField(
                  hint: 'Referral Code',
                  controller: controller.refCode,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0.sp),
                  child: Text(
                    "Official Information",
                    style: TextStyle(color: Colors.black.withOpacity(0.75), fontWeight: FontWeight.w500, fontSize: 15.sp),
                  ),
                ),
                OurTextField(hint: 'Hours of work', controller: controller.workingHours, keyboardType: TextInputType.number),
                SizedBox(
                  height: 10.sp,
                ),
                OurTextField(hint: 'Bank Account Number', controller: controller.bankAccNumber, keyboardType: TextInputType.number),
                SizedBox(
                  height: 10.sp,
                ),
                OurTextField(hint: 'Bank BSB', controller: controller.bankBsb),
                SizedBox(
                  height: 10.sp,
                ),
                OurListObjectDropDown(
                  dropdownItems: Get.find<SplashController>().licenseStateList.value,
                  hintText: "Select License State",
                  onDropdownChanged: (value) {
                    controller.selectedLicenseState = value['state'];
                  },
                  selectedDropdownItem: controller.selectedLicenseState,
                  keyName: 'state',
                ),
                SizedBox(
                  height: 10.sp,
                ),
                OurListObjectDropDown(
                  dropdownItems: Get.find<SplashController>().licenseTypesList.value,
                  hintText: "Select License Type",
                  onDropdownChanged: (value) {
                    controller.selectedLicenseType = value['id'].toString();
                  },
                  selectedDropdownItem: controller.selectedLicenseType,
                  keyName: 'license_type',
                ),
                SizedBox(
                  height: 10.sp,
                ),
                OurTextField(hint: 'License Number', controller: controller.licenseNumber),
                SizedBox(
                  height: 12.sp,
                ),
                OurTextField(hint: 'ABN', controller: controller.abn),
                SizedBox(
                  height: 12.sp,
                ),
                OurTextField(
                  hint: 'Passport Number',
                  controller: controller.passportNumber,
                ),
                SizedBox(
                  height: 12.sp,
                ),
                OurTextField(hint: 'Passport Country', controller: controller.passportCountry),
                SizedBox(
                  height: 12.sp,
                ),
                OurListStringDropDown(
                  dropdownItems: controller.wagesType,
                  hintText: "Wage Type",
                  onDropdownChanged: (value) {
                    controller.selectedWagesType = value;
                  },
                ),
                SizedBox(
                  height: 12.sp,
                ),
                OurTextField(hint: 'Wage Price', controller: controller.wage),
                SizedBox(
                  height: 12.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Documents",
                        style: TextStyle(color: Colors.black.withOpacity(0.75), fontWeight: FontWeight.w500, fontSize: 15.sp),
                      ),
                      if (widget.isEdit == true)
                        TextButton(
                            onPressed: () {
                              photoList = [
                                {"label": "Profile Photo", "url": widget.editData['photo_url'] ?? ""},
                                {"label": "Passport Front", "url": widget.editData['passport_url'] ?? ""},
                                {"label": "Passport Back", "url": widget.editData['passport_back_url'] ?? ""},
                                {"label": "Visa", "url": widget.editData['visa_url'] ?? ""},
                                {"label": "ABN", "url": widget.editData['abn_url'] ?? ""},
                                {"label": "License", "url": widget.editData['license_url'] ?? ""},
                                {"label": "Signature", "url": widget.editData['signature_url'] ?? ""},
                              ];
                              Get.to(OurPhotoView(galleryImages: photoList));
                            },
                            child: Text("View"))
                    ],
                  ),
                ),
                Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SelectImageButton(
                          isSelected: controller.profilePhotoPath.value.isNotEmpty,
                          label: "Select Profile Photo",
                          title: controller.profilePhotoPath.value.isNotEmpty ? "Profile Photo Selected" : null,
                          onTap: () {
                            controller.selectImage(ImageType.profilePhoto);
                          },
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        SelectImageButton(
                          isSelected: controller.licensePhotoPath.value.isNotEmpty,
                          label: "Select License Front Photo",
                          title: controller.licensePhotoPath.value.isNotEmpty ? "License Front Photo Selected" : null,
                          onTap: () {
                            controller.selectImage(ImageType.license);
                          },
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        SelectImageButton(
                          isSelected: controller.licenseBackPhotoPath.value.isNotEmpty,
                          label: "Select License Back Photo",
                          title: controller.licenseBackPhotoPath.value.isNotEmpty ? "License Back Photo Selected" : null,
                          onTap: () {
                            controller.selectImage(ImageType.licenseBack);
                          },
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OurTextField(
                                hint: 'Visa From',
                                controller: controller.visaFromDate,
                                isReadOnly: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.selectDOB(false).then((value) {
                                      controller.visaFromDate.text = value;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.date_range,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: OurTextField(
                                hint: 'Visa to',
                                controller: controller.visaToDate,
                                isReadOnly: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.selectDOB(false).then((value) {
                                      controller.visaToDate.text = value;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.date_range,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        SelectImageButton(
                          isSelected: controller.visaPhotoPath.value.isNotEmpty,
                          label: "Select Visa Photo",
                          title: controller.visaPhotoPath.value.isNotEmpty ? "Visa Photo Selected" : null,
                          onTap: () {
                            controller.selectImage(ImageType.visa);
                          },
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        SelectImageButton(
                          isSelected: controller.abnPhotoPath.value.isNotEmpty,
                          label: "Select ABN Photo",
                          title: controller.abnPhotoPath.value.isNotEmpty ? "ABN Photo Selected" : null,
                          onTap: () {
                            controller.selectImage(ImageType.abn);
                          },
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        SelectImageButton(
                          isSelected: controller.passportFrontPhotoPath.value.isNotEmpty,
                          label: "Select Passport Front Photo",
                          title: controller.passportFrontPhotoPath.value.isNotEmpty ? "Front Passport Photo Selected" : null,
                          onTap: () {
                            controller.selectImage(ImageType.passportFront);
                          },
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        SelectImageButton(
                          isSelected: controller.passportBackPhotoPath.value.isNotEmpty,
                          label: "Select Passport Back Photo",
                          title: controller.passportBackPhotoPath.value.isNotEmpty ? "Back Passport Photo Selected" : null,
                          onTap: () {
                            controller.selectImage(ImageType.passportBack);
                          },
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        SelectImageButton(
                          isSelected: controller.signaturePhotoPath.value.isNotEmpty,
                          label: "Signature",
                          title: controller.signaturePhotoPath.value.isNotEmpty ? "Signature Added" : null,
                          onTap: () {
                            // controller.selectImage(ImageType.signature);
                            final SignatureController _controller = SignatureController(
                              penStrokeWidth: 1,
                              penColor: Colors.orange,
                              exportBackgroundColor: Colors.transparent,
                              exportPenColor: Colors.black,
                            );
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  color: OurColor.scaffoldBG,
                                  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Please put your signature below.",
                                            style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _controller.clear();
                                            },
                                            child: Text(
                                              "Clear",
                                              style: TextStyle(color: OurColor.highlightBG, fontSize: 16.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Signature(
                                        key: const Key('signature'),
                                        controller: _controller,
                                        height: 300,
                                        backgroundColor: Colors.transparent,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  side: const BorderSide(width: 1.0, color: Colors.white), padding: EdgeInsets.symmetric(vertical: 14.sp)),
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                "Close",
                                                style: TextStyle(fontSize: 16.sp, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12.sp,
                                          ),
                                          Expanded(
                                            child: OurButton(
                                                onTap: () async {
                                                  await _controller.toPngBytes(height: 1000, width: 1000).then((value) async {
                                                    Uint8List yourUint8ListData = value!; // Replace with your data
                                                    String fileName = 'signature.jpg'; // Replace with your desired file name
                                                    controller.signaturePhotoPath.value = await controller.saveUint8ListToFile(yourUint8ListData, fileName);
                                                    Get.back();
                                                  });
                                                },
                                                title: 'Submit'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    )),
                SizedBox(
                  height: 12.sp,
                ),
                OurListStringDropDown(
                  hintText: 'Select Break',
                  dropdownItems: controller.breakType,
                  onDropdownChanged: (value) {
                    controller.selectedBreakType = value;
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.sp),
                  title: Text(
                    "Is User Active",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  trailing: Obx(() => Switch(
                        onChanged: (value) {
                          controller.isUserActive.value = value;
                        },
                        value: controller.isUserActive.value,
                      )),
                ),
                OurButton(
                  onTap: () {
                    if (widget.isEdit == false) {
                      controller.onRegisterDriver(context);
                    } else {
                      context.loaderOverlay.show();
                      controller.editDriver(widget.editData['id'].toString()).then((value) async {
                        context.loaderOverlay.hide();
                        if (value.statusCode == 200) {
                          await controller.getDriverLists();
                          HelpingMethods.showToast('Updated Successfully');
                          Get.back();
                        } else {
                          HelpingMethods.showToast('Not Updated');
                        }
                      }).onError((error, stackTrace) {
                        context.loaderOverlay.hide();
                        HelpingMethods.showToast(error.toString());
                      });
                    }
                  },
                  title: widget.isEdit == false ? 'Create my Account' : 'Update Information',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
