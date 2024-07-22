import 'package:dams_cash/components/admin_bottom_bar.dart';
import 'package:dams_cash/components/sidebar.dart';
import 'package:dams_cash/models/auth.dart';
import 'package:dams_cash/models/branch.dart';
import 'package:dams_cash/models/user.dart';
import 'package:dams_cash/pages/sellerstock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AdminStockPage extends StatefulWidget {
  const AdminStockPage({super.key}); 



  @override
  State<AdminStockPage> createState() => _AdminStockPageState();
}

class _AdminStockPageState extends State<AdminStockPage> with SingleTickerProviderStateMixin{
  List<User> _getAllUser(List<User> fullUser){
    return fullUser.toList();
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
        title: const Text('Stok Produk'),
      ),
      drawer: const Sidebar(),
      body: Column(
        children: [
        FutureBuilder(
          future: Provider.of<Auth>(context, listen: false).fetchUser(),
          builder: (contexts, snapshot) {
            return Expanded(
            child: Consumer<Auth>(
              builder: (context, auth, child){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                } else {
                return ListView(
                children: _getAllUser(auth.users).map((user) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text("Stok Seller ${user.name}"),
                          subtitle: Text(user.isAdmin ? 'Admin' : 'Seller'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              final branch = Provider.of<Branch>(context, listen: false);
                              branch.fetchProductByUserId(user.id);
                              Navigator.push(context, MaterialPageRoute(builder:(context) => const SellerStockPage()));
                            },
                            child: const Text('Lihat Stok'),
                          )
                        ),
                        Divider(color: Colors.grey[300], thickness: 1, height: 0, indent: 10, endIndent: 10,),
                      ],
                    );
                }).toList(),
              );}
              }
            ),
            );
          }
        ),
        const AdminBottomBar(currentIndex: 0)
        ],
      ),
    );
  }
}