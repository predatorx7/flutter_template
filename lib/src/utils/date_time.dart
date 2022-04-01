import 'package:flutter/material.dart';

DateTime toDateTime(TimeOfDay time) {
  final DateTime dateNow = DateTime.now();
  return DateTime(
    dateNow.year,
    dateNow.month,
    dateNow.day,
    time.hour,
    time.minute,
  );
}
