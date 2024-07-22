import 'package:dams_cash/models/rank.dart';
import 'package:dams_cash/models/sale.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Sales extends ChangeNotifier{
    final List<Sale> _sales = [];

  List<Sale> get sales => _sales;

  Future<http.Response> fetchSales() async {
      final response = await http.get(Uri.parse('https://script.google.com/macros/s/AKfycbzkgCgjFnO5bE6olnlmftk5gl7nUO_CDErsuHPvmdGb2qsvY0QDdhIw-b5BKTp-6LDJ/exec'));
      if (response.statusCode == 200) {
        _sales.clear();
        final List<dynamic> sales = jsonDecode(response.body);
        for (var sale in sales) {
          _sales.insert(0, Sale.fromJson(sale));
          notifyListeners();
        }
        return response;
      } else {
        throw Exception('Failed to load sales');
      }
  }
  
  Future<http.Response> fetchSalesToday() async {
      final response = await http.get(Uri.parse('https://script.google.com/macros/s/AKfycbzkgCgjFnO5bE6olnlmftk5gl7nUO_CDErsuHPvmdGb2qsvY0QDdhIw-b5BKTp-6LDJ/exec'));
      if (response.statusCode == 200) {
        _sales.clear();
        final List<dynamic> sales = jsonDecode(response.body);
        for (var sale in sales) {
          if(sale['date'].toString().contains(DateTime.now().toString().substring(0,10))){
            _sales.insert(0, Sale.fromJson(sale));
            notifyListeners();
          }
        }
        return response;
      } else {
        throw Exception('Failed to load sales');
      }
  }

  List<Ranking> _rank = [];
  List<Ranking> get rank => _rank;

  void getRank(){
    _rank.clear();
    for (var sale in _sales) {
      var index = _rank.indexWhere((element) => element.userId == sale.userId);
      if(index == -1){
        _rank.add(Ranking(userId: sale.userId, userName:sale.userName, totalProfit: sale.profit));
      }else{
        _rank[index].totalProfit += sale.profit;
      }
    }
    _rank.sort((a, b) => b.totalProfit.compareTo(a.totalProfit));
    notifyListeners();
  }
}