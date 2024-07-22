import 'package:dams_cash/components/bottom_bar.dart';
import 'package:dams_cash/components/sidebar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      drawer: const Sidebar(),
      body: Column(
        children: [
          Expanded(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: const Center(
            child: Text(
              'Selamat Datang di DAMs Cash',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          )
        ),
          ),
        const BottomBar(currentIndex: 1,)
        ],
      ),
    );
  }
}