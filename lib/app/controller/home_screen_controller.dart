import 'package:flutter/material.dart';

class HomeScreenController extends ChangeNotifier {
  bool productDetails = true;
  productDetailsUpdate(bool value) {
    productDetails = value;
    notifyListeners();
  }
}
