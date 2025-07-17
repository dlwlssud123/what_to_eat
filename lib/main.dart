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
  final Map<String, List<String>> foodMap = {
    '한식': ['비빔밥', '김치찌개', '불고기'],
    '중식': ['짜장면', '짬뽕', '탕수육'],
    '일식': ['초밥', '라멘', '가츠동'],
    '양식': ['파스타', '스테이크', '피자'],
  };

  String? recommendedFood;
  bool showCategoryButtons = false;

  void recommendRandomFood() {
    final allFoods = foodMap.values.expand((list) => list).toList();
    allFoods.shuffle();
    setState(() {
      recommendedFood = allFoods.first;
    });
  }

  void recommendByCategory(String category) {
    final foods = foodMap[category];
    if (foods != null && foods.isNotEmpty) {
      foods.shuffle();
      setState(() {
        recommendedFood = foods.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('오늘 뭐 먹지?'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 랜덤 음식 추천 버튼
            ElevatedButton(
              onPressed: recommendRandomFood,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('🍽️ 랜덤 음식 추천', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 20),

            // 카테고리 토글 버튼
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showCategoryButtons = !showCategoryButtons;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                '📂 카테고리별 음식 추천',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),

            // 카테고리 버튼들 (2x2 Grid)
            if (showCategoryButtons)
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                children: foodMap.keys.map((category) {
                  return ElevatedButton(
                    onPressed: () => recommendByCategory(category),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(12),
                    ),
                    child: Text(category, style: const TextStyle(fontSize: 18)),
                  );
                }).toList(),
              ),
            const SizedBox(height: 30),

            // 추천 결과 표시
            if (recommendedFood != null)
              Center(
                child: Text(
                  '🍽️ 추천 음식: $recommendedFood',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
