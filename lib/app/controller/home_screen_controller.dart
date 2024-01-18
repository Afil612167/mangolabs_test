import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mangolabs_test/app/model/product_grid_style_enum.dart';
import 'package:mangolabs_test/app/model/product_model.dart';

class HomeScreenController extends ChangeNotifier {
  ProductGridStyles productGridStyle = ProductGridStyles.style1;
  productGridExpandedUpdate(ProductGridStyles value) {
    productGridStyle = value;
    notifyListeners();
  }

  String apiUrl = 'https://fakestoreapi.com/products';
  bool isProductApiLoading = false;
  String productApiError = "";

  List<ProductModel> products = [];

  fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        products = data.map((json) => ProductModel.fromJson(json)).toList();
        print("products ${products[0].category}");
      } else {
        productApiError = response.statusCode.toString();
      }
    } catch (e) {
      productApiError = e.toString();
    }
    isProductApiLoading = true;
    notifyListeners();
  }
}
