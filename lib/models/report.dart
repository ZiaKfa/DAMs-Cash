import 'package:dams_cash/models/product.dart';

class ReportItem {
  Product product;
  int quantity;


ReportItem({
  required this.product,
  this.quantity = 1,
});

int get totalPrice {
  return product.price * quantity;
}

int get totalCost {
  return product.productionCost * quantity;
}

int get profit {
  return totalPrice - totalCost;
}
}