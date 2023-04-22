library backappx;

import 'package:http/http.dart' as http;

class Category {
  static final Category _instance = Category._internal();

  factory Category() {
    return _instance;
  }

  Category._internal();

  static final String _baseUrl = 'http://localhost:9092/categorie';
  static final _DeleteCategorie = '$_baseUrl/:CategorieID';
  static final _addCategorie = '$_baseUrl/Addproduct';

  static Future<http.Response> DeleteCategorie(id) async {
  final response = await http.delete(Uri.parse(_DeleteCategorie));

  print(response.body.toString());
  return response;
  }

  static Future<http.Response> addCategorie(name) async {
  final response = await http.post(Uri.parse(_addCategorie), body: {
  'name': name,
  });
  print(response.body);
  return response;
  }

  Future<http.Response> addCategoryToProduct(
  String productId, String categoryId) async {
  final String baseUrl = 'http://localhost:9092';
  final String endpoint = '/product/$productId/category';
  final url = Uri.parse('$baseUrl$endpoint');

  try {
  final response = await http.post(
  url,
  body: {'categoryId': categoryId},
  );
  return response;
  } catch (error) {
  print(error.toString());
  return Future.value(http.Response('Error', 500));
  }
  }
}
