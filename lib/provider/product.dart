import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  String imageURL;
  double price;
  bool isFavourite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageURL,
      required this.price,
      this.isFavourite = false});

  void editProduct(String title, String description, String imageURL, double price) {
    this.title = title;
    this.description = description;
    this.imageURL = imageURL;
    this.price = price;
    notifyListeners();
  }

  void toggleFavorite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
