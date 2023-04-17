library backappx;

import 'project.dart';
import 'package:http/http.dart' as http;

class Product {
  static final String _baseUrl = 'http://localhost:9092/product';
  static final _Getproduct = '$_baseUrl/products';
  static final _getSingleProduct = '$_baseUrl';
  static final _UpdateProduct = '$_baseUrl/:productId';
  static final _DeleteProduct = '$_baseUrl/:productId';
  static final _addProduct = '$_baseUrl/Addproduct';

  static final Product _instance = Product._internal();

  factory Product() {
    return _instance;
  }

  Product._internal();

  Future<http.Response> getProduct(id) async {
    final response = await http.get(Uri.parse(_Getproduct));
    return response;
  }

  Future<http.Response> getSingleProduct(id) async {
    final response = await http.get(Uri.parse('$_getSingleProduct/$id'));

    print(response.body.toString());
    return response;
  }

  Future<http.Response> editProduct(name, price, quantity) async {
    final response = await http.put(Uri.parse(_UpdateProduct), body: {
      'name': name,
      'price': price,
      'quantity': quantity,
      'reference': Project.projectRef,
      //'image': image
    });

    return response;
  }

  Future<http.Response> deleteProduct(id) async {
    final response = await http.delete(Uri.parse(_DeleteProduct));

    return response;
  }

  Future<http.Response> addProduct(quantity, product, client) async {
    final response = await http.post(Uri.parse(_addProduct), body: {
      'quantity': quantity,
      'product': product,
      'client': client,
      'reference': Project.projectRef,
      //'image': image
    });
    return response;
  }
}
