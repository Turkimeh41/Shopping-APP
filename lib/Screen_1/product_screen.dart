// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_local_variable
import 'dart:async';

import 'package:module8/main.dart';
import 'package:flutter/material.dart';
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
  @override
  void didChangeDependencies() {
    if (MyApp.started) {
      Timer(Duration(seconds: 1), () {
        final insProducts = Provider.of<Products>(context, listen: false);
        insProducts.fetchProductsAndSET().then((_) {
          setState(() {});
        });
        MyApp.started = !MyApp.started;
      });
    }
    super.didChangeDependencies();
  }

  Future<void> refresh(BuildContext context) async {
    setState(() {
      MyApp.started = !MyApp.started;
    });
    final insProducts = await Provider.of<Products>(context, listen: false).fetchProductsAndSET();
    Timer(Duration(seconds: 1), () {
      setState(() {
        MyApp.started = !MyApp.started;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: RichText(
          text: TextSpan(
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              children: [TextSpan(text: 'Refreshed', style: TextStyle(color: Theme.of(context).primaryColor)), TextSpan(text: ' !')]),
        )));
      });
    });
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
              builder: (context, cart, child) => b.Badge(
                  child: IconButton(
                    color: Theme.of(context).iconTheme.color,
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
        body: RefreshIndicator(
          onRefresh: () => refresh(context),
          child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: MyApp.started
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ProductDisplay(_showFav)),
        ));
  }
}
