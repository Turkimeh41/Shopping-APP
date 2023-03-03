import 'package:flutter/material.dart';
import 'package:module8/Order_Screen/order_screen.dart';
import 'package:module8/Screen_0/auth_screen.dart';
import 'package:module8/Screen_1/product_screen.dart';
import 'package:module8/provider/orders.dart';
import './Screen_2/productdetails_screen.dart';
import './provider/products.dart';
import 'package:provider/provider.dart';
import './provider/cart.dart';
import 'Screen_Cart/cart_screen.dart';
import 'Add_Products_Screen/user_products.dart';
import 'provider/user.dart';
import 'package:module8/provider/user.dart';

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
            create: (context) => User(),
          ),
          ChangeNotifierProxyProvider<User, Products>(
            update: (context, auth, previous) => Products(auth.token, previous == null ? [] : previous.products),
            create: (context) => Products('', []),
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProxyProvider<User, Orders>(
            update: (context, auth, previous) => Orders(auth.token, previous == null ? [] : previous.getOrders),
            create: (context) => Orders('', []),
          )
        ],
        child: Consumer<User>(
            builder: (context, insAuth, child) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter',
                  theme: ThemeData(
                    colorScheme: const ColorScheme(
                      /*Light Color OF Icons*/ primary: Color.fromARGB(255, 126, 12, 111),
                      /*Dark Color OF Icon/Buttons*/ secondary: Color.fromARGB(255, 126, 12, 111),
                      onPrimary: Colors.white,
                      onSecondary: Colors.amber,
                      /*BACKGROUND OF APP*/ background: Color.fromARGB(255, 241, 234, 228),
                      /*Appbar,Big Widgets etc*/ onBackground: Color.fromARGB(255, 126, 12, 111),
                      surface: Color.fromARGB(255, 231, 214, 199),
                      onSurface: Color.fromARGB(255, 0, 0, 0),
                      error: Color.fromARGB(255, 233, 56, 44),
                      onError: Color.fromARGB(255, 124, 8, 0),
                      brightness: Brightness.light,
                    ),
                  ),
                  home: insAuth.isAuth ? const ProductScreen() : const AuthScreen(),
                  routes: {
                    ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
                    CartScreen.routeName: (context) => const CartScreen(),
                    OrderScreen.routeName: (context) => const OrderScreen(),
                    UserProductScreen.routeName: (context) => const UserProductScreen(),
                    AuthScreen.routeName: (context) => const AuthScreen()
                  },
                )));
  }
}
