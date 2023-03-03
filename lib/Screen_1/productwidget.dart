import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Screen_2/productdetails_screen.dart';
import '../provider/product.dart';
import '../provider/cart.dart';
import 'package:module8/provider/user.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<User>(context, listen: false);
    final product = Provider.of<Product>(context);
    return Container(
      foregroundDecoration: BoxDecoration(
        border: Border.all(width: 0.6, color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product);
          },
          child: GridTile(
              child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                product.imageURL,
                fit: BoxFit.cover,
              ),
              Positioned(
                  top: -7,
                  right: -7,
                  child: IconButton(
                    icon: Icon(product.isFavourite ? Icons.favorite : Icons.favorite_border_rounded, size: 30),
                    color: product.isFavourite ? Colors.red : Colors.white,
                    onPressed: () {
                      product.toggleFavorite(auth.token, auth.userID);
                    },
                  )),
              Positioned(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.445,
                  bottom: 0,
                  child: Container(
                    color: const Color.fromARGB(179, 0, 0, 0),
                  )),
              Positioned(
                  width: MediaQuery.of(context).size.width * 0.445,
                  bottom: 11,
                  child: Text(
                    textAlign: TextAlign.center,
                    product.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )),
              Positioned(
                bottom: -6,
                right: -8,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Color.fromARGB(255, 89, 194, 48)),
                  onPressed: () {
                    cart.addToCart(product.id, product.price, product.title);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        '${product.title} Added to cart!',
                      ),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        textColor: const Color.fromARGB(255, 241, 139, 5),
                        label: "UNDO",
                        onPressed: () {
                          cart.undoSingleCart(product.id);
                        },
                      ),
                    ));
                  },
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
