import 'package:flutter/material.dart';
import 'package:module8/Add_Products_Screen/user_products.dart';
import '../Order_Screen/order_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Column(children: [
        AppBar(
          title: const Text(
            'Hi User',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
          },
          leading: const Icon(Icons.payment),
          title: const Text('Orders'),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(UserProductScreen.routeName);
          },
          leading: const Icon(Icons.payment),
          title: const Text('User\'s Added Products'),
        )
      ]),
    );
  }
}
