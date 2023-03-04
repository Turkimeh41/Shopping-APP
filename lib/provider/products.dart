import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class Products with ChangeNotifier {
  final String token;
  final String currentUserID;
  List<Product> _products = [];
  Products(this.token, this.currentUserID, this._products);

  List<Product> get products {
    return [..._products];
  }

  List<Product> get favproducts {
    return _products.where((product) => product.isFavourite == true).toList();
  }

  Future<void> addProduct({required, required title, required description, required imageURL, required price, favorite = false}) async {
    final urlProducts = Uri.parse('https://new-project-ebe4a-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$token');
    try {
      final response = await http.post(urlProducts, body: json.encode({'title': title, 'description': description, 'imageUrl': imageURL, 'price': price, 'uid': currentUserID}));
      _products.add(
          Product(id: json.decode(response.body)['name'], uid: currentUserID, title: title, description: description, imageURL: imageURL, price: price, isFavourite: favorite));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchProductsAndSET(bool filterbyUser) async {
    final List<Product> loadedProducts = [];
    final urlUNFILTERED = 'https://new-project-ebe4a-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$token';
    final urlFILTERED = 'https://new-project-ebe4a-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$token&orderBy="uid"&equalTo="$currentUserID"';
    try {
      final urlProducts = filterbyUser ? Uri.parse(urlFILTERED) : Uri.parse(urlUNFILTERED);

      final response = await http.get(urlProducts);
      final extracted = json.decode(response.body);
      if (extracted == null) {
      } else {
        final urlUserFav = Uri.parse('https://new-project-ebe4a-default-rtdb.europe-west1.firebasedatabase.app/userfavorites/$currentUserID.json?auth=$token');
        final favoriteresponse = await http.get(urlUserFav);
        final favoriteData = json.decode(favoriteresponse.body);
        final extracted = json.decode(response.body) as Map<String, dynamic>;
        extracted.forEach((pID, value) {
          loadedProducts.add(Product(
              id: pID,
              uid: value['uid'],
              title: value['title'],
              description: value['description'],
              imageURL: value['imageUrl'],
              price: value['price'],
              //  FIRST CHECK IF THE WHOLE FIELD (A NEW USER HASN'T FAVORITED ANYTHING) SECOND CHECK FOR EACH FIELD IF IT'S NULL, THE DOUBLE ?? IS CHECKING IF THE FIELD IS NULL = FALSE IF NOT PUT FAVORITEDATA[pID]
              isFavourite: favoriteData == null ? false : favoriteData[pID] ?? false));
          _products = loadedProducts;
          notifyListeners();
        });
      }
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
    final urlProduct = Uri.parse('new-project-ebe4a-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$token');
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
