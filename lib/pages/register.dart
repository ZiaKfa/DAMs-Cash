import 'package:dams_cash/auth/login_or_register.dart';
import 'package:dams_cash/components/button.dart';
import 'package:dams_cash/components/text_field.dart';
import 'package:dams_cash/models/auth.dart';
import 'package:dams_cash/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final void Function()? onTap;

  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();

}

class _RegisterState extends State<Register> {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Register')),
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
              'Buat Akun',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: nameController,
              hintText: 'Nama',
              obscureText: false,
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
            const SizedBox(height: 20),
            CustomTextField(
              controller: confirmPasswordController,
              hintText: 'Konfirmasi Password',
              obscureText: true,
            ),
            const SizedBox(height: 30),
            CustomButton(text: "Daftar", onTap:(){
              final auth = Provider.of<Auth>(context, listen: false);
              final registeredUser = User(
                id: auth.users.length + 1,
                name: nameController.text,
                email: emailController.text,
                password: passwordController.text,
                isAdmin: false,
              );
              auth.register(registeredUser);
              auth.postUser(registeredUser);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Registrasi Berhasil'),
                    content: const Text('Registrasi berhasil, silahkan login'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginOrRegister()));
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Sudah punya akun? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Masuk',
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


