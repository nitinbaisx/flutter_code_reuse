import 'dart:convert';
import 'package:newproject/modals/ProductsModal.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://dummyjson.com/products";

  Future<List<Product>> fetchProducts(int skip, int limit) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?skip=$skip&limit=$limit'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<dynamic> productsList = jsonData['products'];
        print('------productsList-----${productsList}');

        return productsList
            .map((product) => Product.fromJson(product))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Error fetching products: $e");
      throw Exception('Failed to load products');
    }
  }
}
