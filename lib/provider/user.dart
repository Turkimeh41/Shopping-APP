// ignore_for_file: use_rethrow_when_possible
import 'package:const_date_time/const_date_time.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:module8/model/http_exception.dart';

class User with ChangeNotifier {
  String token;
  DateTime expiryDate;
  String userID;
  User({this.token = '', this.expiryDate = const ConstDateTime(0), this.userID = ''});

  bool get isAuth {
    return token != '';
  }

  String get getToken {
    if (expiryDate != const ConstDateTime(0) && expiryDate.isAfter(DateTime.now()) && token != '') {
      return token;
    }
    return '';
  }

  Future<void> _authentication(String email, String password, String urlSegment) async {
    final authAPI = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyA8Lp6y_Vzhg-XLT1j4um8oTTdUKpOJrj0');
    try {
      final response = await http.post(authAPI, body: json.encode({'email': email, 'password': password, 'returnSecureToken': true}));
      final extracted = json.decode(response.body);
      /*IF AN ERROR HAPPNED FROM THE RESPONSE FIREBASE API*/
      if (extracted['error'] != null) {
        throw HTTPException(extracted['error']['message']);
      } /*LOGIN THE USER GET HIS TOKEN*/
      else {
        token = extracted['idToken'];
        userID = extracted['localId'];
        expiryDate = DateTime.now().add(Duration(seconds: int.parse(extracted['expiresIn'])));
      }
      /*CATCH ERROR FOR GENERIC ERRORS, INTERNET CONNECTION ETC ETC*/
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  Future<void> userSIGNUP(String email, String password) async {
    return _authentication(email, password, 'signUp');
  }

  Future<void> userLOGIN(String email, String password) async {
    return _authentication(email, password, 'signInWithPassword');
  }
}
