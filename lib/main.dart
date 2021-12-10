import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobliecontroller/src/login.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

void main() async {
  await initialize();
  runApp(myApp());
}

initialize() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}


class myApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MobileController',
      home: LogIn(),
    );
  }
}


