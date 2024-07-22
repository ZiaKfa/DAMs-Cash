import 'package:http/http.dart' as http;
import 'dart:convert';


Product productFromJson(String str) {
  final jsonData = json.decode(str);
  return Product.fromJson(jsonData);
}

String productToJson(Product data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Product {
  final int id;
  final String name;
  final String category;
  final int price;
  int stock; 
  final int? volume;
  final int productionCost;
  final int userId;

  Product ({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    this.volume,
    required this.productionCost,
    required this.userId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      stock: json['stock'],
      volume: json['volume'],
      productionCost: json['productionCost'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': category,
      'price': price,
      'stock': stock,
      'volume': volume,
      'productionCost': productionCost,
      'userId': userId,
    };
  }
  Future<http.Response> updateStock(Product product,int stock) async {
    final response = await http.post(
      Uri.parse('https://script.google.com/macros/s/AKfycbwpQQwXyoBGKKqQyagVYVfTUZnw2UV00_HG8qcd_Bvk-7O1ryIks9WqGtpBkjCFzaAe/exec'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': product.id,
        'stock': stock,
      }),
    );
    return response;
  }
}

