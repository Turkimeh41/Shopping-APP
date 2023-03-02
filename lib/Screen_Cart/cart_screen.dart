import 'package:flutter/material.dart';
import 'package:module8/Screen_Cart/cartdisplay.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = 'Products/Cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          centerTitle: true,
          title: const Text(
            "MY CART",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          )),
      body: const CartDisplay(),
    );
  }
}
