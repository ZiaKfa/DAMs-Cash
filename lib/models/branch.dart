import 'package:dams_cash/models/report.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product.dart';
import 'dart:developer';

class Branch extends ChangeNotifier {

Future<http.Response> fetchProducts() async {
    if (_fullProducts.isEmpty) {
      final response = await http.get(Uri.parse('https://script.googleusercontent.com/macros/echo?user_content_key=X7VFpS47XCH_kBZawHKaO0cPec9cngl7RLm2deTgTTrcBlYmbSxYkvjhI8fV95GgxxIxhaWfUgkZJEB2FbHFNlb6kSSUDMVhm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnHlL9jT2vO1udgJdvY-WjqtFB_JW5I3YsYexRJOOaX1cGAgwXIpXk96RSVJxk6c6GrNmhwNE_17PIG3Ma_s_Ussnw5zFWm3PXA&lib=MPgjlcXF8kb0MaUhhcpulVOFv7QlOchAA'));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, then parse the JSON.
        final List<dynamic> products = jsonDecode(response.body);
        for (var product in products) {
          _fullProducts.add(Product.fromJson(product));
          notifyListeners();
        }
        log(response.body);
        return response;
      } else {
        // If the server returns an error response, then throw an exception.
        throw Exception('Failed to load products');
      }
    } else {
      return Future.value(http.Response('Products already fetched', 200));
    }
}

Future<http.Response> fetchProductByUserId(int userId) async {
      final response = await http.get(Uri.parse('https://script.googleusercontent.com/macros/echo?user_content_key=X7VFpS47XCH_kBZawHKaO0cPec9cngl7RLm2deTgTTrcBlYmbSxYkvjhI8fV95GgxxIxhaWfUgkZJEB2FbHFNlb6kSSUDMVhm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnHlL9jT2vO1udgJdvY-WjqtFB_JW5I3YsYexRJOOaX1cGAgwXIpXk96RSVJxk6c6GrNmhwNE_17PIG3Ma_s_Ussnw5zFWm3PXA&lib=MPgjlcXF8kb0MaUhhcpulVOFv7QlOchAA'));
      if (response.statusCode == 200) {
        _products.clear();
        // If the server returns a 200 OK response, then parse the JSON.
        final List<dynamic> products = jsonDecode(response.body);
        for (var product in products) {
          if (product['userId'] == userId) {
            _products.add(Product.fromJson(product));
            notifyListeners();
          }
        }
        log(response.body);
        return response;
      } else {
        // If the server returns an error response, then throw an exception.
        throw Exception('Failed to load products');
      }
}


  final List<Product> _products = [
      
  ];
  final List<Product> _fullProducts = [

  ];

  bool isEmpty(){
    return _products.isEmpty;
  }

  List<Product> get products => _products;
  List<Product> get fullProducts => _fullProducts;
  List<ReportItem> get report => _report;

  final List<ReportItem> _report = [];

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void clearProducts() {
    _products.clear();
    notifyListeners();
  }

  void addToReport(Product product) {
    ReportItem? existingItem = _report.firstWhereOrNull((item){
      bool isSameProduct = item.product.name == product.name;

      return isSameProduct;
    });

    if (existingItem != null) {
      existingItem.quantity++;
      existingItem.product.stock--;
      existingItem.product.updateStock(existingItem.product,existingItem.product.stock);
    } else {
      _report.add(ReportItem(product: product));
      product.stock--;
      product.updateStock(product,product.stock);
    }
  }

  void removeFromReport(ReportItem item) {
    int index = _report.indexOf(item);

    if (index != -1) {
      if (_report[index].quantity > 1) {
        _report[index].quantity--;
        _report[index].product.stock++;
        _report[index].product.updateStock(_report[index].product,_report[index].product.stock);
      } else {
        _report[index].product.stock++;
        _report[index].product.updateStock(_report[index].product,_report[index].product.stock);
        _report.removeAt(index);
      }
    }
  }

  double getTotalPrice() {
    double total = 0;

    for (ReportItem item in _report) {
      int itemPrice = item.totalPrice;
      total += itemPrice;
    }

    return total;
  }

  double getTotalProductionCost() {
    double total = 0;

    for (ReportItem item in _report) {
      int itemCost = item.totalCost;
      total += itemCost;
    }

    return total;
  }
  
  double getTotalProfit() {
    double total = 0;

    for (ReportItem item in _report) {
      int itemProfit = item.profit;
      total += itemProfit;
    }

    return total;
  }

  int getItemCount(){
    int itemCount = 0;
    for (ReportItem item in _report) {
      itemCount += item.quantity;
    }
    return itemCount;
  }
  
  void clearReport() {
    for (ReportItem item in _report) {
      item.product.stock += item.quantity;
      item.product.updateStock(item.product,item.product.stock);
    }
    _report.clear();
    notifyListeners();
  }

  void clearReportWithoutRestock() {
    _report.clear();
    notifyListeners();
  }
  
  Future<http.Response> postSale(int userId, String name) async {
    final response = await http.post(
      Uri.parse('https://script.google.com/macros/s/AKfycbw9qDf1AACelcLNfa2g8pN71vjjb9IKC1E0gE-FUvdNGepOeNiSouv9SD0iNGsMvesE/exec'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'date': DateTime.now().toIso8601String(),
        'userId': userId,
        'userName': name,
        'quantity': getItemCount(),
        'profit': getTotalProfit(),
      }),
    );
    return response;
  }

  Future<http.Response> postProduct (Product product) async {
    final response = await http.post(
      Uri.parse('https://script.google.com/macros/s/AKfycbz7m23b_msrPJo_genQMNA6VPitBfLQw1_DzX5mkdS2CANzFofSmzG5sad3las85pOu/exec'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': product.id,
        'name': product.name,
        'category': product.category,
        'price': product.price,
        'stock': product.stock,
        'volume': product.volume,
        'productionCost': product.productionCost,
        'userId': product.userId,
      }),
    );
    return response;
  }

  void updateAllStock() {
    for (Product product in _products) {
      product.updateStock(product,product.stock);
    }
  }
}