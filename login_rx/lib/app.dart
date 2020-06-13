import 'package:flutter/material.dart';
import 'package:login_rx/login_screen.dart';
import 'blocs/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: LoginScreen(),
        ),
      )
    );
  }
}
