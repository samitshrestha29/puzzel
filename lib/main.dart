import 'package:bible_puzzle_game/home_page/iphone_mini2.dart';
import 'package:bible_puzzle_game/home_page/iphone_mini4.dart';
import 'package:bible_puzzle_game/home_page/iphone_mini7.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IphoneMini7(),
    );
  }
}
