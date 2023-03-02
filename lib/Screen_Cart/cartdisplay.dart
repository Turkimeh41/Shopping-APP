// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:module8/Screen_Cart/cartwidget.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../provider/orders.dart';

class CartDisplay extends StatelessWidget {
  const CartDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(
      context,
    );
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cart.carts.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Text(
                    "No Orders have been placed",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )))
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: cart.carts.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: cart.carts[index],
                        child: CartWidget(cart: cart),
                      );
                    },
                  )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  textAlign: TextAlign.start,
                  "Order Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: Column(children: [
                      Row(
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            '\$${cart.totalCart.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ])),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  final insOrders = Provider.of<Orders>(context, listen: false);
                  insOrders.addOrder(double.parse(cart.totalCart.toStringAsFixed(2)), cart.carts);
                  cart.clearCart();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.purple),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: BorderSide(color: Colors.purple)))),
                child: Text("FINALIZE YOUR ORDER "),
              )
            ],
          )
        ],
      ),
    );
  }
}
