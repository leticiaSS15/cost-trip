import 'package:cost_trip/auth/db_auth.dart';
import 'package:cost_trip/pages/home_page.dart';
import 'package:cost_trip/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrHome extends StatelessWidget {
  const AuthOrHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DbAuth _auth = Provider.of(context);
    return _auth.isAuth ? HomePage() : LoginPage();
  }
}

