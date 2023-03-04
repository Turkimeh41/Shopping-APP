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
    final device = MediaQuery.of(context).size;
    return Column(
      children: [
        Card(
            elevation: 10,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.all(8),
              height: 60,
              child: Row(children: [
                SizedBox(
                  width: device.width * 0.3,
                  child: Column(
                    children: [
                      Text(
                        'TOTAL: \$${insOrder.total}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy hh:mm').format(insOrder.time),
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: device.width * 0.48,
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    icon: Icon(
                      _expanded ? Icons.arrow_drop_down : Icons.expand_less_outlined,
                      color: Colors.black87,
                      size: 25,
                    ))
              ]),
            )),
        AnimatedContainer(
          padding: const EdgeInsets.all(5),
          duration: const Duration(milliseconds: 400),
          curve: Curves.linear,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 0.8, color: Colors.black)),
          margin: const EdgeInsets.only(bottom: 1),
          height: _expanded ? min(insOrder.products.length * 80.0 + 20.0, 256) : 0,
          child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                    thickness: 1.5,
                    height: 15,
                  ),
              itemBuilder: (context, index) {
                return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    decoration: BoxDecoration(border: Border.all(width: 0.5), borderRadius: BorderRadius.circular(7)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.network(
                        product.findByID(insOrder.products[index].pId).imageURL,
                        fit: BoxFit.cover,
                        height: 64,
                        width: 64,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SizedBox(
                    width: device.width * 0.4,
                    child: Text(
                      insOrder.products[index].title,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    '${insOrder.products[index].quantity}x',
                    style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    '\$${(insOrder.products[index].price * insOrder.products[index].quantity).toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ]);
              },
              itemCount: insOrder.products.length),
        )
      ],
    );
  }
}
