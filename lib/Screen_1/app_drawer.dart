import 'package:flutter/material.dart';
import 'package:module8/Add_Products_Screen/user_products.dart';
import '../Order_Screen/order_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      width: 250,
      child: Column(children: [
        AppBar(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          title: const Text(
            'Hi User',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
          shape:
              RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 1.2), borderRadius: BorderRadius.circular(8)),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
          },
          leading: const Icon(
            Icons.payment,
            color: Colors.black,
          ),
          title: const Text(
            'Orders',
            style: TextStyle(color: Colors.black),
          ),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(UserProductScreen.routeName);
          },
          shape:
              RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 1.2), borderRadius: BorderRadius.circular(8)),
          leading: const Icon(
            Icons.payment,
            color: Colors.black,
          ),
          title: const Text(
            'User\'s Added Products',
            style: TextStyle(color: Colors.black),
          ),
        )
      ]),
    );
  }
}
