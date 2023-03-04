import 'package:flutter/material.dart';
import 'package:module8/provider/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = 'products/productdetails';
  const ProductDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final device = MediaQuery.of(context).size;
    return Scaffold(
/*       appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        centerTitle: true,
        title: Text(product.title),
      ), */
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.title,
                textAlign: TextAlign.center,
              ),
              background: SizedBox(
                  height: device.height * 0.33,
                  width: device.width,
                  child: Hero(
                    tag: product.id,
                    child: Image.network(
                      product.imageURL,
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: device.height * 0.01,
            ),
            Text(
              '\$${product.price.toString()}',
              style: TextStyle(color: Color.fromARGB(255, 109, 108, 108), fontSize: 25),
            ),
            SizedBox(
              height: device.height * 0.01,
            ),
            Container(
              alignment: Alignment.center,
              width: device.width * 0.8,
              child: Text(
                product.description,
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 25),
              ),
            )
          ]))
        ],
      ),
    );
  }
}
