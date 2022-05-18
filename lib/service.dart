

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/WeekData.dart';


Future getdata_week() async {
  final String filurl = 'https://iot-project-13d59-default-rtdb.asia-southeast1.firebasedatabase.app/dien_nang_tuan.json';
  try {
    List<DienNangTuan> data = [];
    http.Response response = await http.get('$filurl');
    var respon = json.decode(response.body);
     data = dienNangTuanFromJson(response.body);
    return data;
  } catch (e) {
    // ignore: avoid_print
    print('Server Handler : error : ' + e.toString());
    rethrow;
  }
}