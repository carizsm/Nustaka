// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// Impor model Anda
import '../models/product.dart'; // Sesuaikan path
// ... impor model lain

class ApiService {
  // Sesuaikan dengan base URL API Anda
  // Untuk Android Emulator dari API lokal:
  static const String _baseUrl = 'http://10.0.2.2:8000/api';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<Map<String, String>> _getHeaders({bool includeAuth = false}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    if (includeAuth) {
      final token = await _getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  // Contoh: Login User
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/login'),
      headers: await _getHeaders(),
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // Simpan token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', data['token'] as String);
      return data; // Mengembalikan {'token': ..., 'user': ...}
    } else {
      // Coba parse pesan error dari API
      String message = 'Login failed';
      try {
        message = jsonDecode(response.body)['message'] ?? message;
      } catch (_) {}
      throw Exception('$message (Status: ${response.statusCode})');
    }
  }

  // Contoh: Mendapatkan Daftar Produk (FullyEnrichedProduct)
  Future<List<FullyEnrichedProduct>> getProducts({
    String? categoryId,
    String? regionId,
    int page = 1,
    int limit = 10
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
    };
    if (categoryId != null) queryParams['category_id'] = categoryId;
    if (regionId != null) queryParams['region_id'] = regionId;

    final uri = Uri.parse('$_baseUrl/products').replace(queryParameters: queryParams);

    final response = await http.get(uri, headers: await _getHeaders());

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes); // Handle karakter UTF-8
      final Map<String, dynamic> data = jsonDecode(decodedBody);
      final List<dynamic> productListJson = data['data'] as List<dynamic>;
      return productListJson.map((json) => FullyEnrichedProduct.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load products (Status: ${response.statusCode})');
    }
  }

  // Contoh: Mendapatkan Detail Produk
  Future<FullyEnrichedProduct> getProductById(String productId) async {
    final response = await http.get(
        Uri.parse('$_baseUrl/products/$productId'),
        headers: await _getHeaders()
    );
    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      return FullyEnrichedProduct.fromJson(jsonDecode(decodedBody) as Map<String, dynamic>);
    } else if (response.statusCode == 404) {
      throw Exception('Product not found (Status: 404)');
    }
    else {
      throw Exception('Failed to load product details (Status: ${response.statusCode})');
    }
  }

// ... Tambahkan method lain untuk endpoint:
// registerUser, getCurrentUser, updateUser, deleteUser
// addToCart, getCart, updateCartItem, deleteCartItem
// createOrder, getOrders, getOrderById
// createReview, getReviewsByProduct
// getMyProducts (untuk seller)
// Pastikan menggunakan header Authorization untuk endpoint yang memerlukan autentikasi
}