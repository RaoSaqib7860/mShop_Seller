import 'dart:developer';
import 'package:flutter/foundation.dart';

printMethod(String data) {
  if (kDebugMode) {
    log(data);
  }
}
