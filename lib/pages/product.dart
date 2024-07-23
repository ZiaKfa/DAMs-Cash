import 'package:dams_cash/components/bottom_bar.dart';
import 'package:dams_cash/components/sidebar.dart';
import 'package:dams_cash/models/auth.dart';
import 'package:dams_cash/models/branch.dart';
import 'package:dams_cash/models/product.dart';
import 'package:dams_cash/pages/addproduct.dart';
import 'package:dams_cash/pages/report.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({super.key}); 



  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with SingleTickerProviderStateMixin{
  List<Product> _getAllProduct(List<Product> fullProduct){
    return fullProduct.toList();
  }
  
  late TabController _tabController;

  @override
  void initState() {
    
    _tabController = TabController(length: 1, vsync: this);
    final branch = Provider.of<Branch>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    branch.fetchProductByUserId(auth.currentUser.id); // Replace `someFunction()` with the actual function you want to call from the Branch model
    branch.fetchProducts();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void addToReport(Product product) {
    final branch = Provider.of<Branch>(context, listen: false);
    branch.addToReport(product);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ReportPage()),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
      ),
      drawer: const Sidebar(),
      body: Column(
        children: [
        FutureBuilder(
          future: Provider.of<Branch>(context, listen: false).fetchProducts(),
          builder: (context, snapshot) {
            return Expanded(
            child: Consumer<Branch>(
                builder: (context, branch, child) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                return ListView(
                  children: _getAllProduct(branch.products).map((product) {
                  return ListTile(
                    leading: Image.asset("lib/assets/images/${product.category}.jpg", width: 80, height: 100, fit: BoxFit.cover),             
                    title: product.volume != null ? Text("${product.name} ${product.volume}ml") : Text(product.name),
                    subtitle: Text("Rp.${product.price}\nStok: ${product.stock}"),
                    trailing: ElevatedButton(
                    onPressed: () {
                      addToReport(product);
                    },
                    child: const Text('Terjual'),
                    ),
                  );
                  }).toList(),
                );
                }
          }),
            );
          }
        ),
        const BottomBar(currentIndex: 1)
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }
}