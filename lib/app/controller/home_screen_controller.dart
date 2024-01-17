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

  Future<List<ProductModel>> fetchProducts() async {
    String apiUrl = 'https://fakestoreapi.com/products';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ProductModel> products =
            data.map((json) => ProductModel.fromJson(json)).toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
