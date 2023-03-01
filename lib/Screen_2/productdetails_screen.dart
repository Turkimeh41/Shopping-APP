import 'package:flutter/material.dart';
import 'package:module8/provider/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = 'products/productdetails';
  const ProductDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(product.title)),
    );
  }
}
