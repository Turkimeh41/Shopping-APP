import 'package:flutter/material.dart';
import 'package:module8/Screen_1/productwidget.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';

class ProductDisplay extends StatelessWidget {
  final bool showfav;

  const ProductDisplay(this.showfav, {super.key});
  @override
  Widget build(BuildContext context) {
    //Instance of PRODUCTS class, access the method .products to get copy of the list
    final instanceProducts = Provider.of<Products>(context);
    final products =
        showfav ? instanceProducts.favproducts : instanceProducts.products;
    return Container(
      margin: const EdgeInsets.all(15),
      color: Theme.of(context).backgroundColor,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15),
        itemBuilder: (context, i) {
          return ChangeNotifierProvider.value(
            value: products[i],
            child: const ProductWidget(),
          );
        },
        itemCount: products.length,
      ),
    );
  }
}
