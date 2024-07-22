import 'package:dams_cash/components/admin_bottom_bar.dart';
import 'package:dams_cash/components/sidebar.dart';
import 'package:dams_cash/models/sales.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  void initState() {
    super.initState();
    Provider.of<Sales>(context, listen: false).getRank();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Seller'),
      ),
      drawer: const Sidebar(),
      body: Column(
        children: [
          Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Consumer<Sales>(
            builder: (context, sales, child) {
              return ListView.builder(
                itemCount: sales.rank.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(sales.rank[index].userName),
                      trailing: Text("Rp. ${sales.rank[index].totalProfit}", style: const TextStyle(fontSize: 15),),
                      subtitle: Text("Ranking : ${index + 1}"),
                    ),
                  );
                },
              );
            },
          ),
        ),
          ),
        const AdminBottomBar(currentIndex: 2,)
        ],
      ),
    );
  }
}