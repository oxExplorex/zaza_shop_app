import 'package:dio/dio.dart';

import '../models/product.dart';

class ProductApi {
  static const String _url =
      "https://kolzsticks.github.io/Free-Ecommerce-Products-Api/main/products.json";

  final Dio _dio = Dio();

  Future<List<Product>> getProducts() async {
    final response = await _dio.get(_url);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load: ${response.statusCode} ${response.data}',
      );
    }

    final List<dynamic> data = response.data;

    return data.map((json) => Product.fromJson(json)).toList();
  }
}
