import 'package:dams_cash/models/branch.dart';
import 'package:dams_cash/pages/report.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Branch>(
      builder: (context, branch, child) {
        final totalProductsSold = branch.getItemCount().toString();
        final totalProfit = branch.getTotalProfit().toString();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                branch.clearReportWithoutRestock();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportPage()));
              },
            ),
            title: const Text('Rangkuman Laporan'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Jumlah Produk Terjual:',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  totalProductsSold,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Total Omzet :',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'Rp. $totalProfit',
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}