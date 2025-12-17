import 'package:flutter/material.dart';
import 'screens/menu_screen.dart'; // Import màn hình chính chứa Drawer

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tran Quoc Tuan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Bắt đầu từ màn hình MenuScreen
      home: MenuScreen(),
    );
  }
}