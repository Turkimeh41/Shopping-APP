import 'package:flutter/material.dart';
import 'package:module8/Order_Screen/order_screen.dart';
import 'package:module8/Screen_1/product_screen.dart';
import 'package:module8/provider/orders.dart';
import './Screen_2/productdetails_screen.dart';
import './provider/products.dart';
import 'package:provider/provider.dart';
import './provider/cart.dart';
import 'Screen_Cart/cart_screen.dart';
import 'Add_Products_Screen/user_products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static bool started = true;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.purple),
          colorScheme: const ColorScheme(
            onPrimary: Color.fromARGB(255, 241, 234, 228),
            onSecondary: Color.fromARGB(255, 241, 234, 228),
            error: Colors.red,
            onError: Color.fromARGB(255, 124, 8, 0),
            onBackground: Colors.black,
            onSurface: Colors.black,
            primary: Color.fromARGB(255, 241, 234, 228),
            surface: Colors.black,
            background: Color.fromARGB(255, 241, 234, 228),
            brightness: Brightness.dark,
            secondary: Color.fromARGB(255, 241, 234, 228),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          primarySwatch: Colors.amber,
        ),
        home: const ProductScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrderScreen.routeName: (context) => const OrderScreen(),
          UserProductScreen.routeName: (context) => const UserProductScreen()
        },
      ),
    );
  }
}
