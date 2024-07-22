import 'package:dams_cash/models/branch.dart';
import 'package:dams_cash/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SellerStockPage extends StatefulWidget {
  const SellerStockPage({super.key}); 



  @override
  State<SellerStockPage> createState() => _StockPageState();
}

class _StockPageState extends State<SellerStockPage> with SingleTickerProviderStateMixin{
  List<Product> _getAllProduct(List<Product> fullProduct){
    return fullProduct.toList();
  }
  
  late TabController _tabController;

  @override
  void initState() {

    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final branch = Provider.of<Branch>(context, listen: false);
            branch.clearProducts();
            Navigator.pop(context);
          },
        ),
        title: const Text('Stok Produk'),
      ),
      body: Column(
        children: [
        Expanded(
        child: Consumer<Branch>(
          builder: (context, branch, child) =>ListView(
            children: _getAllProduct(branch.products).map((product) {
                return ListTile(
                leading: Image.asset("lib/assets/images/${product.category}.jpg", width: 100, height: 100, fit: BoxFit.cover),             
                title: product.volume != null ? Text("${product.name} ${product.volume}ml") : Text(product.name),
                subtitle: const Text(" "),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Stok: ${product.stock}", style: const TextStyle(fontSize: 14)),
                  ],
                ),
                );
            }).toList(),
          ),
        ),
        ),
        ],
      ),
    );
  }
}