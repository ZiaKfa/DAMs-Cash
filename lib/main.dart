import 'package:dams_cash/auth/login_or_register.dart';
import 'package:dams_cash/models/auth.dart';
import 'package:dams_cash/models/sales.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/branch.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => Branch()),
        ChangeNotifierProvider(create: (context) => Sales()),
      ],
    child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dams Cash',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginOrRegister(),
    );
  }
}