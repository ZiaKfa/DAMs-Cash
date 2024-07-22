import 'package:dams_cash/auth/login_or_register.dart';
import 'package:dams_cash/components/sidebar_tile.dart';
import 'package:dams_cash/models/branch.dart';
import 'package:dams_cash/pages/homepage.dart';
import 'package:dams_cash/pages/salepage.dart';
import 'package:flutter/material.dart';
import 'package:dams_cash/models/auth.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});
  

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final branch = Provider.of<Branch>(context);
    final currentUser = auth.currentUser;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Selamat Datang \n ${currentUser.name}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),

          ),
          SidebarTile(
            icon: Icons.home,
            text: 'Home',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context) => const Home()));
            },
          ),
          currentUser.isAdmin ?
          SidebarTile(
            icon: Icons.admin_panel_settings,
            text: 'Admin Panel',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context) => const SalePage()));
            },
          ) : Container() ,
          SidebarTile(
          icon: Icons.logout,
          text: 'Logout',
          onTap: () {
            auth.logout();
            branch.clearProducts();
            Navigator.push(context, MaterialPageRoute(builder:(context) => const LoginOrRegister()));
          },
        ),
        ],
      ),
    );
  }
}