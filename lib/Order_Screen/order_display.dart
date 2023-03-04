import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:module8/Order_Screen/order_widget.dart';
import '../provider/orders.dart';
import 'package:provider/provider.dart';

class OrderDisplay extends StatefulWidget {
  const OrderDisplay({super.key});

  @override
  State<OrderDisplay> createState() => _OrderDisplayState();
}

class _OrderDisplayState extends State<OrderDisplay> {
  var anim = true;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      final insOrders = Provider.of<Orders>(context, listen: false);
      insOrders.fetchOrders();
      setState(() {
        anim = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final insOrders = Provider.of<Orders>(context);
    return Container(
      color: Theme.of(context).colorScheme.background,
      margin: const EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height,
      child: anim
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: insOrders.getOrders.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(value: insOrders.getOrders[index], child: const OrderWidget());
              },
            ),
    );
  }
}
