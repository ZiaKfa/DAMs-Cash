import 'package:flutter/material.dart';

class QuantityNotifier extends ChangeNotifier {
  int _quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  QuantityNotifier({required int initialQuantity, required this.onAdd, required this.onRemove})
      : _quantity = initialQuantity;

  int get quantity => _quantity;

  void increment() {
    _quantity++;
    onAdd();
    notifyListeners();
  }

  void decrement() {
    if (_quantity > 0) {
      _quantity--;
      onRemove();
      notifyListeners();
    }
  }
}
