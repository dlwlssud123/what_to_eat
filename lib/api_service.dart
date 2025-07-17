// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'meal.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // 랜덤 음식 가져오기
  static Future<Meal?> fetchRandomMeal() async {
    final response = await http.get(Uri.parse('$baseUrl/random.php'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Meal.fromJson(json['meals'][0]);
    } else {
      throw Exception('랜덤 음식 불러오기 실패');
    }
  }

  // 카테고리별 음식 (주의: 실제 있는 카테고리명을 써야 함)
  static Future<Meal?> fetchMealByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$baseUrl/filter.php?c=$category'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final meals = json['meals'];
      if (meals != null && meals.isNotEmpty) {
        final random = (meals..shuffle()).first;
        return Meal(
          id: random['idMeal'],
          name: random['strMeal'],
          imageUrl: random['strMealThumb'],
        );
      } else {
        throw Exception('해당 카테고리에 음식 없음');
      }
    } else {
      throw Exception('카테고리 음식 불러오기 실패');
    }
  }
}
