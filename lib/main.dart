import 'package:flutter/material.dart';
import 'api_service.dart';
import 'meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'What To Eat',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Meal? _selectedMeal;

  void _getRandomMeal() async {
    final meal = await ApiService.fetchRandomMeal();
    setState(() => _selectedMeal = meal);
  }

  void _getMealByCategory(String category) async {
    final meal = await ApiService.fetchMealByCategory(category);
    setState(() => _selectedMeal = meal);
  }

  Widget _buildMealCard() {
    if (_selectedMeal == null) return const SizedBox.shrink();
    return Card(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Image.network(
            _selectedMeal!.imageUrl,
            height: 200, // 또는 MediaQuery로 동적 조정
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _selectedMeal!.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = {
      'Seafood': '해산물',
      'Beef': '소고기',
      'Chicken': '닭고기',
      'Dessert': '디저트',
    };

    return Scaffold(
      appBar: AppBar(title: const Text('오늘 뭐 먹지?')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _getRandomMeal,
            child: const Text('랜덤 음식 추천'),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: categories.entries.map((entry) {
              return ElevatedButton(
                onPressed: () => _getMealByCategory(entry.key),
                child: Text(entry.value),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          if (_selectedMeal != null) _buildMealCard(),
        ],
      ),
    );
  }
}
