import 'package:dams_cash/components/bottom_bar.dart';
import 'package:dams_cash/components/quantity_selector.dart';
import 'package:dams_cash/components/sidebar.dart';
import 'package:dams_cash/models/auth.dart';
import 'package:dams_cash/models/branch.dart';
import 'package:dams_cash/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class StockPage extends StatefulWidget {
  const StockPage({super.key}); 



  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> with SingleTickerProviderStateMixin{
  List<Product> _getAllProduct(List<Product> fullProduct){
    return fullProduct.toList();
  }
  
  late TabController _tabController;

  @override
  void initState() {

    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    final branch = Provider.of<Branch>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    branch.fetchProducts(); // Replace `someFunction()` with the actual function you want to call from the Branch model
    branch.fetchProductByUserId(auth.currentUser.id);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void stockIncrement(Product product) {
    product.stock++;
    product.updateStock(product,product.stock);
  }

  void stockDecrement(Product product) {
    product.stock--;
    product.updateStock(product,product.stock);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stok Produk'),
      ),
      drawer: const Sidebar(),
      body: Column(
        children: [
        Expanded(
        child: Consumer<Branch>(
          builder: (context, branch, child) {
            return ListView(
            children: _getAllProduct(branch.products).map((product) {
                return ListTile(
                leading: Image.asset("lib/assets/images/${product.category}.jpg", width: 100, height: 100, fit: BoxFit.cover),             
                title: product.volume != null ? Text("${product.name} ${product.volume}ml") : Text(product.name),
                subtitle: const Text(" "),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    QuantitySelector(
                      quantity: product.stock,
                      product: product, 
                      onAdd: (){
                        setState(() {
                          stockIncrement(product);
                        });
                      }, 
                      onRemove: (){
                        setState(() {
                          stockDecrement(product);
                        });
                      }
                      ),
                  ],
                ),
                );
            }).toList(),
          );}
        ),
        ),
        const BottomBar(currentIndex: 0)
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: () {
            final branch = Provider.of<Branch>(context, listen: false);
            branch.updateAllStock();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Stok barang di update'),
              ),
            );
          },
          child: const Icon(Icons.save),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }
}