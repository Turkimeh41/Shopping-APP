import 'package:flutter/foundation.dart';
import '../provider/cart.dart';

class OrderItem with ChangeNotifier {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime time;
  OrderItem({required this.id, required this.amount, required this.products, required this.time});
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get getOrders {
    return [..._orders];
  }

  void addOrder(double amount, List<CartItem> products) {
    _orders.insert(0, OrderItem(id: iD(), amount: amount, products: products, time: DateTime.now()));
    notifyListeners();
  }

  String iD() {
    String id = (_orders.length + 1).toString();

    return id;
  }
}
