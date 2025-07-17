import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(WhatToEatApp());
}

class WhatToEatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '오늘 뭐 먹지?',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> foods = [
    '김치찌개',
    '삼겹살',
    '치킨',
    '피자',
    '제육볶음',
    '떡볶이',
    '된장찌개',
    '초밥',
  ];

  String? selectedFood;

  void pickRandomFood() {
    final random = Random();
    setState(() {
      selectedFood = foods[random.nextInt(foods.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('오늘 뭐 먹지?'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedFood ?? '아직 선택되지 않았어요!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: pickRandomFood, child: Text('음식 추천받기')),
          ],
        ),
      ),
    );
  }
}
