import 'dart:math';
import 'package:flutter/material.dart';
import 'package:module8/provider/products.dart';
import 'package:provider/provider.dart';
import '../provider/orders.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  _OrderWidgetState();
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final insOrder = Provider.of<OrderItem>(context);
    final product = Provider.of<Products>(context, listen: false);
    return Column(
      children: [
        Card(
            elevation: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
                Column(
                  children: [
                    Text(
                      'TOTAL: \$${insOrder.amount}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      DateFormat.yMMMd().format(insOrder.time),
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 200,
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    icon: Icon(
                      _expanded ? Icons.arrow_drop_down : Icons.expand_less_rounded,
                      color: Colors.black87,
                      size: 25,
                    ))
              ]),
            )),
        if (_expanded)
          Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1.5, color: Colors.black)),
            margin: const EdgeInsets.all(10),
            height: min(insOrder.products.length * 20.0 + 140.0, 256),
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    Image.network(
                      product.findByID(insOrder.products[index].pId).imageURL,
                      fit: BoxFit.cover,
                      height: 64,
                      width: 64,
                    ),
                    Text(
                      insOrder.products[index].title,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('${insOrder.products[index].quantity}'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '\$${(insOrder.products[index].price * insOrder.products[index].quantity).toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    )
                  ]);
                },
                itemCount: insOrder.products.length),
          )
      ],
    );
  }
}
