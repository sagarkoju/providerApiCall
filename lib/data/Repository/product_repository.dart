// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webapp/data/model/product.dart';
import 'package:webapp/service/product_service.dart';

class ProductRepository {
  final ProductService productService;
  ProductRepository({
    required this.productService,
  });
  //  ProductResponse _productDetail = ProductResponse();

  // ProductResponse get productDetail => _productDetail;
  Future<List<ProductResponse>> getProductList() async {
    final response = await productService.getProduct();
    if (response!.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final posts = json.map((e) => ProductResponse.fromJson(e)).toList();
      return posts;
    } else {
      throw Exception('Failed to load Product');
    }
  }
}

class productProvider extends ChangeNotifier {
  final _service = ProductService();
  List<ProductResponse> _productDetail = [];
  List<ProductResponse> get productDetail => _productDetail;
  bool isLoading = false;

  Future<void> getAllProduct() async {
    isLoading = true;

    final response = await _service.getProduct();

    if (response != null) {
      if (response.statusCode == 200) {
        final responseData = response
            .body; // Assuming your response body contains the product data
        final List<ProductResponse> productList =
            productResponseFromJson(responseData);
        _productDetail = productList;
      } else {
        // Handle the case where the response status code is not 200
        print("Request failed with status: ${response.statusCode}");
      }
    } else {
      // Handle the case where the response is null
      print("Response is null");
    }

    isLoading = false;
    notifyListeners();
  }
}
