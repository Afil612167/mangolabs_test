import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List> fetchProduct(String? route) async {
  String apiUrl = route != null
      ? 'https://fakestoreapi.com/products/$route'
      : "https://fakestoreapi.com/products/";

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data
      List data = json.decode(response.body);

      return data;
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions such as network errors

    throw Exception('Failed to load data. Error: $e');
  }
}
