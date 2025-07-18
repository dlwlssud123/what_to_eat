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
<<<<<<< HEAD
  String? _lastSelectedCategory;
  List<Meal> _favorites = []; // 🎯 즐겨찾기 리스트
  bool _showFavorites = false;

  void _getRandomMeal() async {
    final meal = await ApiService.fetchRandomMeal();
    setState(() {
      _selectedMeal = meal;
      _lastSelectedCategory = null;
      _showFavorites = false;
    });
=======

  void _getRandomMeal() async {
    final meal = await ApiService.fetchRandomMeal();
    setState(() => _selectedMeal = meal);
>>>>>>> feature/FoodAPI
  }

  void _getMealByCategory(String category) async {
    final meal = await ApiService.fetchMealByCategory(category);
<<<<<<< HEAD
    setState(() {
      _selectedMeal = meal;
      _lastSelectedCategory = category;
      _showFavorites = false;
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      if (_favorites.any((m) => m.id == meal.id)) {
        _favorites.removeWhere((m) => m.id == meal.id);
      } else {
        _favorites.add(meal);
      }
    });
  }

  bool _isFavorite(Meal meal) {
    return _favorites.any((m) => m.id == meal.id);
  }

  Widget _buildMealCard(Meal meal) {
=======
    setState(() => _selectedMeal = meal);
  }

  Widget _buildMealCard() {
    if (_selectedMeal == null) return const SizedBox.shrink();
>>>>>>> feature/FoodAPI
    return Card(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Image.network(
<<<<<<< HEAD
            meal.imageUrl,
            height: 200,
=======
            _selectedMeal!.imageUrl,
            height: 200, // 또는 MediaQuery로 동적 조정
>>>>>>> feature/FoodAPI
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
<<<<<<< HEAD
              meal.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () => _toggleFavorite(meal),
            child: Text(_isFavorite(meal) ? '즐겨찾기 제거' : '즐겨찾기 추가'),
          ),
=======
              _selectedMeal!.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
>>>>>>> feature/FoodAPI
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
<<<<<<< HEAD
      appBar: AppBar(
        title: const Text('오늘 뭐 먹지?'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              setState(() {
                _showFavorites = !_showFavorites;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getRandomMeal,
              child: const Text('랜덤 음식 추천'),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
            if (_showFavorites)
              Column(
                children: _favorites
                    .map((meal) => _buildMealCard(meal))
                    .toList(),
              )
            else if (_selectedMeal != null) ...[
              _buildMealCard(_selectedMeal!),
              if (_lastSelectedCategory != null)
                ElevatedButton(
                  onPressed: () => _getMealByCategory(_lastSelectedCategory!),
                  child: Text('${categories[_lastSelectedCategory]} 다시 추천'),
                ),
            ],
          ],
        ),
=======
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
>>>>>>> feature/FoodAPI
      ),
    );
  }
}
