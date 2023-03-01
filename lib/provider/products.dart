import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageURL:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: '2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: '3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageURL:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: '4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get products {
    return [..._products];
  }

  List<Product> get favproducts {
    return _products.where((product) => product.isFavourite == true).toList();
  }

  Future<void> addProduct(
      {required title,
      required description,
      required imageURL,
      required price,
      favorite = false}) {
    final url = Uri.https(
        'flutter-7dhc-default-rtdb.europe-west1.firebasedatabase.app',
        '/products.json');
    return http
        .post(url,
            body: json.encode({
              'title': title,
              'description': description,
              'imageUrl': imageURL,
              'price': price,
              'isfavorite': favorite
            }))
        .then((response) {
      _products.add(Product(
          id: json.decode(response.body)['name'],
          title: title,
          description: description,
          imageURL: imageURL,
          price: price,
          isFavourite: favorite));
      notifyListeners();
    }).catchError((error) {});
  }

  Product findByID(String id) {
    return _products.firstWhere((element) {
      return element.id == id;
    });
  }

  void removeProduct(String id) {
    for (int i = 0; i < _products.length; i++) {
      if (id == _products[i].id) _products.removeAt(i);
    }
    notifyListeners();
  }
}
