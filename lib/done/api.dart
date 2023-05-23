import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/Category.dart';
import '../model/Product.dart';
import '../model/User.dart';

class APIService {
  static String _host = "https://fakestoreapi.com";

  static Future<dynamic> get(String url) async {
    final response = await http.get(Uri.parse(url));
    dynamic json = jsonDecode(response.body);
    return json;
  }

  static Future<http.Response> post(String url, Map<dynamic, dynamic> value) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(value),
    );
    return response;
  }

  static Future<bool> konekte(Map<dynamic, dynamic> value) async {
    final response = await post("$_host/auth/login", value);
    if (response.statusCode == 200 && jsonDecode(response.body)["token"] != null) {
      return true;
    }
    return false;
  }

  static Future<List<Product>> rekipereLisPwodwi() async {
    List<dynamic> products = await get("$_host/products");
    return products.map((json) => Product.fromMap(json)).toList();
  }

  static Future<List<Product>> rekipereTopPwodwi() async {
    List<dynamic> products = await get("$_host/products?sort=desc&limit=6");
    return products.map((json) => Product.fromMap(json)).toList();
  }

  static Future<List<Product>> rekiperePwodwiPaKategori(String categoryName) async {
    List<dynamic> products = await get("$_host/products/category/$categoryName");
    return products.map((json) => Product.fromMap(json)).toList();
  }

  static Future<List<Category>> rekipereTopKategori() async {
    List<dynamic> categories = await get("$_host/products/categories?sort=desc&limit=4");
    return categories.map((json) => Category.fromString(json)).toList();
  }

  static Future<User> rekipereItilizate(String username) async {
    List<dynamic> users = await get("https://fakestoreapi.com/users");
    users.retainWhere((element) => element["username"] == username);
    return User.fromMap(users[0]);
  }
}
