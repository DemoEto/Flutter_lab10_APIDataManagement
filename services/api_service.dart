// lib/services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

Future<List<Product>> fetchProductsData() async {
  try {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching products: $e');
  }
}

Future<Product> fetchProductById(int id) async {
  try {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/$id'),
    );
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception('Failed to load product: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching product: $e');
  }
}

Future<List<String>> fetchCategories() async {
  try {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/categories'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<String>();
    } else {
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching categories: $e');
  }
}

Future<List<Product>> fetchProductsByCategory(String category) async {
  try {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/category/$category'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception(
        'Failed to load products for category: ${response.statusCode}',
      );
    }
  } catch (e) {
    throw Exception('Error fetching products by category: $e');
  }
}

Future<Product> addProduct(Product product) async {
  try {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'category': product.category,
        'image': product.image,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final dynamic data = json.decode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception('Failed to add product: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error adding product: $e');
  }
}

Future<Product> deleteProduct(int id) async {
  try {
    final response = await http.delete(
      Uri.parse('https://fakestoreapi.com/products/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception('Failed to delete product: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error deleting product: $e');
  }
}

Future<Product> updateProduct(int id, Product product) async {
  try {
    final response = await http.put(
      Uri.parse('https://fakestoreapi.com/products/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'category': product.category,
        'image': product.image,
      }),
    );
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception('Failed to update product: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error updating product: $e');
  }
}
