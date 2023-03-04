// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_local_variable
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:module8/provider/user.dart';
import 'package:module8/Screen_1/badge.dart' as b;
import 'package:module8/Screen_1/app_drawer.dart';
import './productdisplay.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../Screen_Cart/cart_screen.dart';
import '../provider/products.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _showFav = false;
  bool anim = true;

  Future<void> refresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProductsAndSET(false);
    setState(() {
      anim = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          title: const Text(
            "Shopping Menu",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Consumer<Cart>(
              builder: (context, cart, child) => b.Badge(
                  child: IconButton(
                    color: Theme.of(context).colorScheme.onPrimary,
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () => Navigator.of(context).pushNamed(CartScreen.routeName),
                  ),
                  value: cart.itemCount.toString(),
                  color: Colors.white),
            ),
            PopupMenuButton(
              onSelected: (selected) {
                setState(() {
                  if (selected == 0) {
                    _showFav = true;
                  } else if (selected == 1) {
                    _showFav = false;
                  }
                });
                if (selected == 2) {
                  Provider.of<User>(context, listen: false).logout();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    'Logged out',
                    textAlign: TextAlign.center,
                  )));
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text(
                    "only Favourites",
                    style: TextStyle(color: Colors.black),
                  ),
                  value: 0,
                ),
                PopupMenuItem(
                  child: Text(
                    "Show All",
                    style: TextStyle(color: Colors.black),
                  ),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text(
                    "Log Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  value: 2,
                ),
              ],
              icon: Icon(Icons.more_vert),
            )
          ],
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: refresh(context),
          builder: (context, snapshot) => RefreshIndicator(
            onRefresh: () => refresh(context),
            child: Container(alignment: Alignment.center, color: Theme.of(context).colorScheme.background, child: ProductDisplay(_showFav)),
          ),
        ));
  }
}
