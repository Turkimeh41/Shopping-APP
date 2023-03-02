import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class Products with ChangeNotifier {
  final urlProducts = Uri.https('flutter-7dhc-default-rtdb.europe-west1.firebasedatabase.app', '/products.json');

  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  List<Product> get favproducts {
    return _products.where((product) => product.isFavourite == true).toList();
  }

  Future<void> addProduct({required title, required description, required imageURL, required price, favorite = false}) async {
    try {
      final response = await http.post(urlProducts,
          body: json.encode({'title': title, 'description': description, 'imageUrl': imageURL, 'price': price, 'isfavorite': favorite}));
      _products.add(
          Product(id: json.decode(response.body)['name'], title: title, description: description, imageURL: imageURL, price: price, isFavourite: favorite));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchProductsAndSET() async {
    try {
      final response = await http.get(urlProducts);
      final extracted = json.decode(response.body);
      final List<Product> loadedProducts = [];
      if (extracted == Map<String, dynamic>) {
        extracted as Map<String, dynamic>;
        extracted.forEach((pID, value) {
          loadedProducts.add(Product(
              id: pID,
              title: value['title'],
              description: value['description'],
              imageURL: value['imageUrl'],
              price: value['price'],
              isFavourite: value['isfavorite']));
        });
      }
      _products = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Product findByID(String id) {
    return _products.firstWhere((element) {
      return element.id == id;
    });
  }

  Future<void> removeProduct(String id) async {
    final urlProduct = Uri.https('flutter-7dhc-default-rtdb.europe-west1.firebasedatabase.app', '/products/$id.json');
    for (int i = 0; i < _products.length; i++) {
      if (id == _products[i].id) {
        try {
          await http.delete(urlProduct);
          _products.removeAt(i);
        } catch (error) {
          rethrow;
        }
      }
    }
    notifyListeners();
  }
}
