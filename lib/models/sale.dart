class Sale {
  final int userId;
  final String userName;
  final int quantity;
  final int profit;
  final DateTime date;

  Sale({
    required this.userId,
    required this.userName,
    required this.quantity,
    required this.profit,
    required this.date,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      userId: json['userId'],
      userName: json['userName'],
      quantity: json['quantity'],
      profit: json['profit'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'quantity': quantity,
      'profit': profit,
      'date': date.toIso8601String(),
    };
  }
}