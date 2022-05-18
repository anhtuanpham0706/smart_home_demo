import 'package:flutter/material.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 20.0;
const backgroundefort = Color(0xFF404F66);




final otpInputDecoration = InputDecoration(
  filled: true,
    fillColor: Colors.grey,
    focusColor: Colors.grey,
  contentPadding:
  EdgeInsets.symmetric(vertical: 10),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    // borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Color(0xFF757575)),
  );
}
const defaultDuration = Duration(milliseconds: 250);