import 'dart:math';

import 'package:intl/intl.dart';

double radToDeg(double rad) {
  return rad * 180 / pi;
}

double degToRad(double deg) {
  return deg * pi / 180;
}

///format money by '1 234 678,00' template
String formatMoney(double amount) {
  var format = NumberFormat("###.00", "eu");
  return format.format(amount);
}
