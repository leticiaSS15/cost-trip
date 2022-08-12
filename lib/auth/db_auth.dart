import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'auth_exceptions.dart';

class DbAuth with ChangeNotifier {
  String? token;
  DateTime _expireToken = DateTime.now();

  bool get isAuth {
    return token != null;
  }

  String? get geTtoken {
    if (token != null && _expireToken.isAfter(DateTime.now())) {
      return token;
    }
    return null;
  }

  Future<void> login(String email, String senha) async {
    return _auth(email, senha, "signInWithPassword");
  }

  Future<void> signUp(String email, String senha) async {
    return _auth(email, senha, "signUp");
  }

  Future<void> _auth(String email, String senha, String urls) async {
    Uri _authUrl = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urls?key=AIzaSyCSPvGOkyDuFuet3n1axLPAtlfw6OR06VQ ');
    final response = await http.post(_authUrl,
        body: json.encode({
          "email": email,
          "password": senha,
          "returnSecureToken": true,
        }));

    final responseBody = json.decode(response.body);

    if (responseBody["error"] != null) {
      throw AuthExceptions(responseBody['error']['message']);
    } else {
      token = responseBody["idToken"];
      _expireToken = DateTime.now()
          .add(Duration(seconds: int.parse(responseBody["expiresIn"])));
      notifyListeners();
    }
    print(token);
    return Future.value();
  }
}
