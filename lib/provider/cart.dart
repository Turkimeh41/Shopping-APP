import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String title;
  int quantity;
  final double price;
  final String pId;

  CartItem({required this.price, required this.id, required this.title, required this.quantity, required this.pId});
}

class Cart with ChangeNotifier {
  List<CartItem> _carts = [];

  List<CartItem> get carts {
    return [..._carts];
  }

  void addToCart(String productID, double price, String title) {
    for (int i = 0; i < _carts.length; i++) {
      if (_carts[i].pId == productID) {
        _carts[i].quantity = _carts[i].quantity + 1;
        return;
      }
    }
    _carts.add(CartItem(price: price, id: DateTime.now().toString(), title: title, quantity: 1, pId: productID));
    notifyListeners();
  }

  int get itemCount {
    return _carts.length;
  }

  double totalAmount(CartItem item) {
    return item.price;
  }

  double get totalCart {
    var total = 0.0;
    for (int i = 0; i < _carts.length; i++) {
      total += _carts[i].price * _carts[i].quantity;
    }
    return total;
  }

  void deleteCartItem(String productID) {
    for (int i = 0; i < _carts.length; i++) {
      if (productID == _carts[i].pId) {
        _carts.removeAt(i);
        notifyListeners();
        return;
      }
    }
  }

  void clearCart() {
    _carts = [];
    notifyListeners();
  }

  void undoSingleCart(String productID) {
    for (int i = 0; i < _carts.length; i++) {
      if (_carts[i].pId == productID) {
        if (_carts[i].quantity > 1) {
          _carts[i].quantity = _carts[i].quantity - 1;
        } else {
          _carts.removeAt(i);
        }
        notifyListeners();
      }
    }
  }
}
