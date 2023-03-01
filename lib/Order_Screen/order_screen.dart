import 'package:flutter/material.dart';
import 'package:module8/Order_Screen/order_display.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const routeName = 'MainMenu/orders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/');
          },
        ),
        title: const Text('Your Orders'),
        centerTitle: true,
      ),
      body: const OrderDisplay(),
    );
  }
}
