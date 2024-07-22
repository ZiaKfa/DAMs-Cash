import 'package:dams_cash/pages/login.dart';
import 'package:dams_cash/pages/register.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
    bool isLoginPage = true;

    void changePage() {
      setState(() {
        isLoginPage = !isLoginPage;
      });
    }
    
      @override
      Widget build(BuildContext context) {
        if(isLoginPage){
          return Login(onTap: changePage);
        } else {
          return Register(onTap: changePage);
        }
      } 
}