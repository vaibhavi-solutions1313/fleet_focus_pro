// To parse this JSON data, do
//
//     final roasterInfoModel = roasterInfoModelFromJson(jsonString);

import 'dart:convert';

RoasterInfoModel roasterInfoModelFromJson(String str) => RoasterInfoModel.fromJson(json.decode(str));

String roasterInfoModelToJson(RoasterInfoModel data) => json.encode(data.toJson());

class RoasterInfoModel {
  int? id;
  String? rego;
  int? driverId;
  int? status;
  int? vendorId;
  String? startTime;
  String? endTime;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? username;
  String? driverName;

  RoasterInfoModel({
    this.id,
    this.rego,
    this.driverId,
    this.status,
    this.vendorId,
    this.startTime,
    this.endTime,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.driverName,
  });

  factory RoasterInfoModel.fromJson(Map<String, dynamic> json) => RoasterInfoModel(
    id: json["id"],
    rego: json["rego"],
    driverId: json["driver_id"],
    status: json["status"],
    vendorId: json["vendor_id"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    username: json["username"],
    driverName: json["driver_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rego": rego,
    "driver_id": driverId,
    "status": status,
    "vendor_id": vendorId,
    "start_time": startTime,
    "end_time": endTime,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "username": username,
    "driver_name": driverName,
  };
}
