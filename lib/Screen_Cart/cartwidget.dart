import 'package:flutter/material.dart';
import 'package:module8/provider/cart.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';

class CartWidget extends StatelessWidget {
  final Cart cart;
  const CartWidget({required this.cart, super.key});

  @override
  Widget build(BuildContext context) {
    final cartitem = Provider.of<CartItem>(context);
    final product = Provider.of<Products>(context, listen: false).findByID(cartitem.pId);

    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Are you sure'),
              content: const Text('Do you want to remove the item from the cart'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: const Text("Yes"),
                ),
                TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('No'))
              ],
            );
          },
        );
      },
      onDismissed: (_) {
        cart.deleteCartItem(cartitem.pId);
      },
      direction: DismissDirection.endToStart,
      key: ValueKey(cartitem.id),
      background: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(40),
          ),
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 48,
          )),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Card(
          color: Colors.white,
          elevation: 6,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    height: 85,
                    width: 85,
                    product.imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10, left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartitem.title,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 110,
                        height: 45,
                        child: Text(
                          product.description,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(top: 85),
                child: Text(
                  '\$${cartitem.price} x${cartitem.quantity}',
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold, color: cartitem.quantity == 1 ? Colors.white : Colors.grey),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 70, left: 12),
                child: Text(
                  '\$${(cartitem.price * cartitem.quantity).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
