import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String uid;
  String id;
  String title;
  String description;
  String imageURL;
  double price;
  bool isFavourite;
  Product({required this.uid, required this.id, required this.title, required this.description, required this.imageURL, required this.price, this.isFavourite = false});

  Future<void> editProduct(String id, String title, String description, String imageURL, double price, String token) async {
    this.id = id;
    this.title = title;
    this.description = description;
    this.imageURL = imageURL;
    this.price = price;
    final urlProduct = Uri.parse('https://new-project-ebe4a-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$token');
    await http.patch(urlProduct, body: json.encode({'title': title, 'description': description, 'imageUrl': imageURL, 'price': price}));
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String currentUserID) async {
    final oldstatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final urlProduct = Uri.parse('https://new-project-ebe4a-default-rtdb.europe-west1.firebasedatabase.app/userfavorites/$currentUserID/$id.json?auth=$token');
    try {
      await http.put(urlProduct, body: json.encode(isFavourite));
    } catch (error) {
      isFavourite = oldstatus;
      notifyListeners();
      throw error;
    }
  }
}
