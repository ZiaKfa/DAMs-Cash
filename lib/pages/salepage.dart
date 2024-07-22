import 'package:dams_cash/components/admin_bottom_bar.dart';
import 'package:dams_cash/components/sidebar.dart';
import 'package:dams_cash/models/sale.dart';
import 'package:dams_cash/models/sales.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();

}

class _SalePageState extends State<SalePage> {
  List<Sale> _getAllSale(List<Sale> fullSale){
    return fullSale.toList();
  }

  @override
  void initState() {
    super.initState();
    final sales = Provider.of<Sales>(context, listen: false);
    sales.fetchSalesToday();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Omzet Hari Ini'),
      ),
      drawer: const Sidebar(),
      body: Column(
        children: [
        Expanded(
        child: FutureBuilder(
          future: Provider.of<Sales>(context, listen: false).fetchSalesToday(),
          builder: (context,snapshot) {
            return Consumer<Sales>(
              builder: (context, sales, child) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
              return ListView(
                children: _getAllSale(sales.sales).map((sale) {
                    if (sales.sales.isEmpty) {
                      return const Center(
                        child: Text('No sales available'),
                      );
                    } else {
                      return Column(
                        children: [
                          ListTile(
                            title: Text("Seller : ${sale.userName}"),
                            subtitle: Text(DateFormat('dd MMMM yyyy').format(sale.date)),
                            trailing: Text("Omzet : Rp.${sale.profit}\nProduk Terjual :${sale.quantity}", style: const TextStyle(fontSize: 15),),
                          ),
                          Divider(color: Colors.grey[300], thickness: 1, height: 0, indent: 10, endIndent: 10,),
                        ],
                      );
            
                    }
                }).toList(),
              );}
              }
            );
          }
        ),
        ),
        const AdminBottomBar(currentIndex: 1,)
        ],
      ),
    );
  }
}