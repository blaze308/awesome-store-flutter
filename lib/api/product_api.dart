import 'dart:convert';

import 'package:awesomestore/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductsApi {
  final dio = Dio();
  final url = "http://10.0.2.2:4000/api/products";

  Future<List<dynamic>> fetchProducts(BuildContext context) async {
    try {
      final response = await dio.get(
        url,
        options: Options(
            headers: {"Content-Type": "application/json; charset=UTF-8"}),
      );

      var products = response.data;
      print(products);
      return products;
    } catch (e) {
      await Future.delayed(const Duration(seconds: 3));
      if (context.mounted) {
        showSnackBar(context: context, message: e.toString());
      }
      print(e.toString());
    }
    return [];
  }
}
