import 'package:dams_cash/components/bottom_bar.dart';
import 'package:dams_cash/components/button.dart';
import 'package:dams_cash/components/report_tile.dart';
import 'package:dams_cash/components/sidebar.dart';
import 'package:dams_cash/models/auth.dart';
import 'package:dams_cash/pages/summary.dart';
import 'package:flutter/material.dart';
import 'package:dams_cash/models/branch.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return Consumer<Branch>(
      builder: (context, branch, child) {

      final userReport = branch.report;
      branch.getTotalPrice().toStringAsFixed(2);

      return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Penjualan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: (){
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Hapus Laporan'),
                    content: const Text('Apakah anda yakin ingin menghapus laporan?'),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: (){
                          branch.clearReport();
                          Navigator.pop(context);
                        },
                        child: const Text('Hapus'),
                      ),
                    ],
                  );
                }
              );
            },
          )],
      ),
      drawer: const Sidebar(),
      body: Column(
        children: [
          userReport.isEmpty ? 
          const Expanded(child: Center(child: Text("Penjualan Kosong",style: TextStyle(fontSize: 18),))) :  
        Expanded(
        child: ListView.builder(
          itemCount: userReport.length,
          itemBuilder: (context,index){
            final reportItem = userReport[index];
            return ReportTile(reportItem: reportItem);
          }
        ),
        
          ),
        Column(
          children: [
            userReport.isEmpty ? const SizedBox() :
            CustomButton(
              text: "Laporkan!",
              onTap: () {
                
                showDialog(
                  context: context, 
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Laporkan Penjualan'),
                      content: const Text('Anda yakin akan melaporkan?'),
                      actions: [
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: (){
                            branch.postSale(auth.currentUser.id, auth.currentUser.name);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SummaryPage()),
                            );
                          },
                          child: const Text('Laporkan'),
                        ),
                      ],
                    );
                  }
                );
              }
            ),
            const BottomBar(currentIndex: 2)
          ],
        )
        
        ],
      ),
    );
      }

    );


  }
}