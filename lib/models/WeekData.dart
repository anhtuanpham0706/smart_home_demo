// To parse this JSON data, do
//
//     final dienNangTuan = dienNangTuanFromJson(jsonString);

import 'dart:convert';

List<DienNangTuan> dienNangTuanFromJson(String str) => List<DienNangTuan>.from(json.decode(str).map((x) => DienNangTuan.fromJson(x)));

String dienNangTuanToJson(List<DienNangTuan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DienNangTuan {
  DienNangTuan({
    this.chiSo,
    this.ngay,
  });

  int chiSo;
  String ngay;

  factory DienNangTuan.fromJson(Map<String, dynamic> json) => DienNangTuan(
    chiSo: json["chi_so"],
    ngay: json["ngay"],
  );

  Map<String, dynamic> toJson() => {
    "chi_so": chiSo,
    "ngay": ngay,
  };
}
