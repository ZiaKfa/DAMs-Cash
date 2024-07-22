import 'package:dams_cash/components/button.dart';
import 'package:dams_cash/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:dams_cash/components/text_field.dart';
import 'package:dams_cash/models/auth.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;

  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  void initState() {
    final auth = Provider.of<Auth>(context, listen: false);

    super.initState();
    auth.fetchUser();
  }

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void login() {
    // Logika Login
    final auth = Provider.of<Auth>(context, listen: false);
    if(auth.loginWithEmail(emailController.text, passwordController.text)){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Berhasil'),
            content: const Text('Selamat datang di Aplikasi DamsCash'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      ).then((value) => Navigator.push(context, MaterialPageRoute(builder:(context) => const Home(),),),);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email atau Password salah'),
        ),
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Login')),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body : Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/assets/images/logo.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            
            const Text(
              'Masuk',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 30),
            CustomButton(text: "Masuk", onTap:login),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Belum punya akun? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}