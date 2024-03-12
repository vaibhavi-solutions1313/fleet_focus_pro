// To parse this JSON data, do
//
//     final driverItemModel = driverItemModelFromJson(jsonString);

import 'dart:convert';

DriverItemModel driverItemModelFromJson(String str) => DriverItemModel.fromJson(json.decode(str));

String driverItemModelToJson(DriverItemModel data) => json.encode(data.toJson());

class DriverItemModel {
  int? id;
  dynamic driverNumber;
  dynamic address;
  dynamic age;
  dynamic dob;
  dynamic mobileNumber;
  dynamic passportNumber;
  dynamic visaStatusId;
  dynamic visaStartDate;
  dynamic visaEndDate;
  dynamic hoursAllowedToWork;
  dynamic wagesType;
  dynamic wages;
  dynamic breakType;
  dynamic bankBsb;
  dynamic bankAccountNumber;
  dynamic abnumber;
  int? isRegisteredForGst;
  dynamic licenseTypeId;
  dynamic licenseState;
  dynamic licenseNumber;
  dynamic ipAddress;
  dynamic userAgent;
  dynamic photoUrl;
  dynamic passportUrl;
  dynamic passportBackUrl;
  dynamic visaUrl;
  dynamic abnUrl;
  dynamic licenseUrl;
  dynamic signatureUrl;
  dynamic coeUrl;
  dynamic mcUrl;
  dynamic salary;
  dynamic employeeCategory;
  int? isPermanent;
  int? isActive;
  dynamic startDate;
  dynamic endDate;
  int? isAvailable;
  int? userId;
  dynamic licenseBackUrl;
  dynamic passportCountry;
  String? refCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userName;
  String? userEmail;

  DriverItemModel({
    this.id,
    this.driverNumber,
    this.address,
    this.age,
    this.dob,
    this.mobileNumber,
    this.passportNumber,
    this.visaStatusId,
    this.visaStartDate,
    this.visaEndDate,
    this.hoursAllowedToWork,
    this.wagesType,
    this.wages,
    this.breakType,
    this.bankBsb,
    this.bankAccountNumber,
    this.abnumber,
    this.isRegisteredForGst,
    this.licenseTypeId,
    this.licenseState,
    this.licenseNumber,
    this.ipAddress,
    this.userAgent,
    this.photoUrl,
    this.passportUrl,
    this.passportBackUrl,
    this.visaUrl,
    this.abnUrl,
    this.licenseUrl,
    this.signatureUrl,
    this.coeUrl,
    this.mcUrl,
    this.salary,
    this.employeeCategory,
    this.isPermanent,
    this.isActive,
    this.startDate,
    this.endDate,
    this.isAvailable,
    this.userId,
    this.licenseBackUrl,
    this.passportCountry,
    this.refCode,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.userEmail,
  });

  factory DriverItemModel.fromJson(Map<String, dynamic> json) => DriverItemModel(
    id: json["id"],
    driverNumber: json["driver_number"],
    address: json["address"],
    age: json["age"],
    dob: json["dob"],
    mobileNumber: json["mobile_number"],
    passportNumber: json["passport_number"],
    visaStatusId: json["visa_status_id"],
    visaStartDate: json["visa_start_date"],
    visaEndDate: json["visa_end_date"],
    hoursAllowedToWork: json["hours_allowed_to_work"],
    wagesType: json["wages_type"],
    wages: json["wages"],
    breakType: json["break_type"],
    bankBsb: json["bank_bsb"],
    bankAccountNumber: json["bank_account_number"],
    abnumber: json["abnumber"],
    isRegisteredForGst: json["is_registered_for_gst"],
    licenseTypeId: json["license_type_id"],
    licenseState: json["license_state"],
    licenseNumber: json["license_number"],
    ipAddress: json["ip_address"],
    userAgent: json["user_agent"],
    photoUrl: json["photo_url"],
    passportUrl: json["passport_url"],
    passportBackUrl: json["passport_back_url"],
    visaUrl: json["visa_url"],
    abnUrl: json["abn_url"],
    licenseUrl: json["license_url"],
    signatureUrl: json["signature_url"],
    coeUrl: json["coe_url"],
    mcUrl: json["mc_url"],
    salary: json["salary"],
    employeeCategory: json["employee_category"],
    isPermanent: json["is_permanent"],
    isActive: json["is_active"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    isAvailable: json["is_available"],
    userId: json["user_id"],
    licenseBackUrl: json["license_back_url"],
    passportCountry: json["passport_country"],
    refCode: json["ref_code"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    userName: json["user_name"],
    userEmail: json["user_email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driver_number": driverNumber,
    "address": address,
    "age": age,
    "dob": dob,
    "mobile_number": mobileNumber,
    "passport_number": passportNumber,
    "visa_status_id": visaStatusId,
    "visa_start_date": visaStartDate,
    "visa_end_date": visaEndDate,
    "hours_allowed_to_work": hoursAllowedToWork,
    "wages_type": wagesType,
    "wages": wages,
    "break_type": breakType,
    "bank_bsb": bankBsb,
    "bank_account_number": bankAccountNumber,
    "abnumber": abnumber,
    "is_registered_for_gst": isRegisteredForGst,
    "license_type_id": licenseTypeId,
    "license_state": licenseState,
    "license_number": licenseNumber,
    "ip_address": ipAddress,
    "user_agent": userAgent,
    "photo_url": photoUrl,
    "passport_url": passportUrl,
    "passport_back_url": passportBackUrl,
    "visa_url": visaUrl,
    "abn_url": abnUrl,
    "license_url": licenseUrl,
    "signature_url": signatureUrl,
    "coe_url": coeUrl,
    "mc_url": mcUrl,
    "salary": salary,
    "employee_category": employeeCategory,
    "is_permanent": isPermanent,
    "is_active": isActive,
    "start_date": startDate,
    "end_date": endDate,
    "is_available": isAvailable,
    "user_id": userId,
    "license_back_url": licenseBackUrl,
    "passport_country": passportCountry,
    "ref_code": refCode,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user_name": userName,
    "user_email": userEmail,
  };
}