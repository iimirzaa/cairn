import 'package:flutter/material.dart';

class DriverApp extends StatelessWidget {
  const DriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driver',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const Scaffold(body: Center(child: Text('Driver App (Android)'))),
      // replace home with your driver router / first page
    );
  }
}