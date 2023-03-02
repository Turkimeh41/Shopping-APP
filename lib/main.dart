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
          colorScheme: const ColorScheme(
            /*Light Color OF Icons*/ primary: Colors.amber,
            /*Dark Color OF Icon/Buttons*/ secondary: Color.fromARGB(255, 126, 12, 111),
            onPrimary: Colors.white,
            onSecondary: Colors.amber,
            /*BACKGROUND OF APP*/ background: Color.fromARGB(255, 241, 234, 228),
            /*Appbar,Big Widgets etc*/ onBackground: Color.fromARGB(255, 126, 12, 111),
            surface: Colors.white,
            onSurface: Color.fromARGB(255, 0, 0, 0),
            error: Color.fromARGB(255, 233, 56, 44),
            onError: Color.fromARGB(255, 124, 8, 0),
            brightness: Brightness.light,
          ),
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
