// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:module8/Screen_1/badge.dart';
import 'package:module8/Screen_1/app_drawer.dart';
import './productdisplay.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../Screen_Cart/cart_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _showFav = false;

  void selectCart(BuildContext context) {
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Color.fromARGB(255, 131, 1, 182),
          title: const Text(
            "Shopping Menu",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Consumer<Cart>(
              builder: (context, cart, child) => Badge(
                  child: IconButton(
                    color: Theme.of(context).iconTheme.color,
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () => selectCart(context),
                  ),
                  value: cart.itemCount.toString(),
                  color: Colors.white),
            ),
            PopupMenuButton(
              onSelected: (selected) {
                setState(() {
                  if (selected == 0) {
                    _showFav = true;
                  } else {
                    _showFav = false;
                  }
                });
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text(
                    "only Favourites",
                  ),
                  value: 0,
                ),
                PopupMenuItem(
                  child: Text(
                    "Show All",
                  ),
                  value: 1,
                ),
              ],
              icon: Icon(Icons.more_vert),
            )
          ],
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: Container(color: Theme.of(context).backgroundColor, child: ProductDisplay(_showFav)));
  }
}
