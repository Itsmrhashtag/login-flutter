// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:login/register.dart';

import 'home.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login' : (context) => MyLogin(),
      'register' : (context) => Register(),
      'home' : (context) => Home()
    },
  ));
}
