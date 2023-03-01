import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  String imageURL;
  double price;
  bool isFavourite;

  Product({required this.id, required this.title, required this.description, required this.imageURL, required this.price, this.isFavourite = false});

  Future<void> editProduct(String id, String title, String description, String imageURL, double price) async {
    this.id = id;
    this.title = title;
    this.description = description;
    this.imageURL = imageURL;
    this.price = price;
    final urlProduct = Uri.https('flutter-7dhc-default-rtdb.europe-west1.firebasedatabase.app', '/products/$id.json');
    await http.patch(urlProduct, body: json.encode({'title': title, 'description': description, 'imageUrl': imageURL, 'price': price}));
    notifyListeners();
  }

  void toggleFavorite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
