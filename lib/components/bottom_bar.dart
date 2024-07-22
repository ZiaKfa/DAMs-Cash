import 'package:dams_cash/pages/product.dart';
import 'package:dams_cash/pages/report.dart';
import 'package:dams_cash/pages/stock.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  
  const BottomBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder:(context) => const StockPage()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder:(context) => const ProductPage()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder:(context) => const ReportPage()));
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph ),
            label: 'Stok',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Laporan Penjualan',
          ),
        ],
    );
  }
}