import 'package:flutter/foundation.dart';
import '../provider/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//EACH SPECIFIC ORDER, IT CAN HAAVE MULTIPLE PRODUCTS
class OrderItem with ChangeNotifier {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime time;
  OrderItem({this.id = '', required this.total, required this.products, required this.time});
}

class Orders with ChangeNotifier {
  final String token;
  final String userID;
  List<OrderItem> _orders = [];

  Orders(this.token, this.userID, this._orders);

  List<OrderItem> get getOrders {
    return [..._orders];
  }

  Future<void> addOrder(double amount, List<CartItem> products) async {
    final urlOrders = Uri.parse('https://new-project-ebe4a-default-rtdb.europe-west1.firebasedatabase.app/orders/$userID.json?auth=$token');
    final order = OrderItem(total: amount, products: products, time: DateTime.now());
    try {
      await http.post(urlOrders,
          body: json.encode({
            'total': order.total,
            'time': (order.time.toIso8601String()),
            'products': products.map((current) => {'id': current.id, 'title': current.title, 'quantity': current.quantity, 'price': current.price, 'pId': current.pId}).toList()
          }));
      _orders.insert(0, order);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchOrders() async {
    final urlOrders = Uri.parse('https://new-project-ebe4a-default-rtdb.europe-west1.firebasedatabase.app/orders/$userID.json?auth=$token');

    final List<OrderItem> loadedOrders = [];
    try {
      final response = await http.get(urlOrders);
      final extracted = json.decode(response.body);
      if (extracted == null) {
      } else {
        final extracted = json.decode(response.body) as Map<String, dynamic>;

        extracted.forEach((orderID, orderData) {
          loadedOrders.add(OrderItem(
              id: orderID,
              total: orderData['total'],
              time: DateTime.parse(orderData['time']),
              products: (orderData['products'] as List<dynamic>)
                  .map((e) => CartItem(price: e['price'], id: e['id'], title: e['title'], quantity: e['quantity'], pId: e['pId']))
                  .toList()));
        });
      }
    } catch (error) {
      rethrow;
    } finally {
      _orders = loadedOrders;
      notifyListeners();
    }
  }
}
