import 'package:flutter/widgets.dart';

class SetRoasterModel {
  String? date;
  List<TableData>? tableData;

  SetRoasterModel({this.date, this.tableData,});

  SetRoasterModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['tableData'] != null) {
      tableData = <TableData>[];
      json['tableData'].forEach((v) {
        tableData!.add(new TableData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.tableData != null) {
      // Convert each TableData object to a map using toJson
      data['tableData'] = this.tableData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TableData {
  String? rego;
  Type? type;
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  String? startTime;
  String? endTime;

  TableData({this.rego, this.type, this.startTime, this.endTime, required this.startDate, required this.endDate});

  TableData.fromJson(Map<String, dynamic> json) {
    rego = json['rego'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rego'] = this.rego;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }
}

class Type {
  String? id;
  String? label;

  Type({this.id, this.label});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    return data;
  }
}
