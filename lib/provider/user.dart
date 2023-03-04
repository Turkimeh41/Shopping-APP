// ignore_for_file: use_rethrow_when_possible
import 'dart:async';
import 'package:const_date_time/const_date_time.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:module8/model/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  String token;
  DateTime expiryDate;
  String userID;
  User({
    this.token = '',
    this.expiryDate = const ConstDateTime(0),
    this.userID = '',
  });

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
        _autologout();
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({'token': token, 'uid': userID, 'expirydate': expiryDate.toIso8601String()});
        prefs.setString('data', userData);
      }
      /*CATCH ERROR FOR GENERIC ERRORS, INTERNET CONNECTION ETC ETC*/
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout() async {
    token = '';
    userID = '';
    expiryDate = const ConstDateTime(0);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('data');
  }

  void _autologout() {
    final expiryinSeconds = expiryDate.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: expiryinSeconds), () {
      logout();
    });
  }

  Future<void> userSIGNUP(String email, String password) async {
    return _authentication(email, password, 'signUp');
  }

  Future<void> userLOGIN(String email, String password) async {
    return _authentication(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('data')) {
      return false;
    }
    final jsonData = json.decode(prefs.getString('data')!) as Map<String, dynamic>;
    final expirydate = DateTime.parse((jsonData['expirydate']));
    if (expirydate.isBefore(DateTime.now())) {
      return false;
    }
    token = jsonData['token'];
    userID = jsonData['uid'];
    expiryDate = expirydate;
    notifyListeners();
    _autologout();
    return true;
  }
}
