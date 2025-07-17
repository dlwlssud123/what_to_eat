import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const WhatToEatApp());
}

class WhatToEatApp extends StatelessWidget {
  const WhatToEatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'What to Eat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = ['한식', '중식', '일식', '양식'];
  String? selectedCategory;
  String? recommendedFood;

  final Map<String, List<String>> foodMap = {
    '한식': ['비빔밥', '김치찌개', '불고기'],
    '중식': ['짜장면', '짬뽕', '탕수육'],
    '일식': ['초밥', '라멘', '가츠동'],
    '양식': ['파스타', '스테이크', '피자'],
  };

  void recommendFood(String category) {
    final foods = foodMap[category];
    if (foods != null && foods.isNotEmpty) {
      foods.shuffle(); // 무작위 추천
      setState(() {
        selectedCategory = category;
        recommendedFood = foods.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('오늘 뭐 먹지?'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 카테고리 버튼들
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;
                  return ElevatedButton(
                    onPressed: () => recommendFood(category),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected
                          ? Colors.deepOrange
                          : Colors.grey[300],
                      foregroundColor: isSelected ? Colors.white : Colors.black,
                    ),
                    child: Text(category),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            // 추천 음식 표시
            if (recommendedFood != null)
              Text(
                '추천 음식: $recommendedFood',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
