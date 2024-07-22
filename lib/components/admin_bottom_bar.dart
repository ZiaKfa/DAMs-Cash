import 'package:dams_cash/pages/adminstock.dart';
import 'package:dams_cash/pages/rating.dart';
import 'package:dams_cash/pages/salepage.dart';
import 'package:flutter/material.dart';

class AdminBottomBar extends StatelessWidget {
  final int currentIndex;
  
  const AdminBottomBar({
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
            Navigator.push(context, MaterialPageRoute(builder:(context) => const AdminStockPage()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder:(context) => const SalePage()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder:(context) => const Rating()));
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph ),
            label: 'Laporan Stok',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Laporan Omzet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Top Seller',
          ),
        ],
    );
  }
}