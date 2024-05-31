import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Authorization {
  static String? username;
  static String? password;
  static String? token;
}

Image? imageFromBase64String(String base64Image) {
  if (base64Image.isNotEmpty) {
    return Image.memory(base64Decode(base64Image));
  }
  return null;
}

String formatNumber(dynamic) {
  var f = NumberFormat('###,##0.00', 'bs');
  if (dynamic == null) {
    return "";
  } else {
    return f.format(dynamic);
  }
}

class Utils {
  static formatPrice(double price) => '\KM ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat("dd.MM.yyyy").format(date);
  static formatDateTime(DateTime date) => DateFormat("dd.MM.yyyy hh:mm").format(date);
  static formatTime(DateTime date) => DateFormat("HH:mm").format(date);
}
