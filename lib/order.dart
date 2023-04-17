library backappx;
import 'project.dart';
import 'package:http/http.dart' as http;


class Order {
  static final String _baseUrl = 'http://localhost:9092/order';
  static final _GetOrder = '$_baseUrl/orders';
  static final _AddOrder = '$_baseUrl/addorder';
  static final _GetOrderByID = '$_baseUrl/:orderId';
  static final _DeleteOrder = '$_baseUrl/:orderId';

  static final Order _instance = Order._internal();

  factory Order() {
    return _instance;
  }

  Order._internal();

  Future<http.Response> getOrder(id) async {
    final response = await http.get(Uri.parse(_GetOrder));

    print(response.body.toString());
    return response;
  }

  Future<http.Response> addOrder(quantity, productId, clientId) async {
    final response = await http.post(Uri.parse(_AddOrder), body: {
      'quantity': quantity,
      'productId': productId,
      'clientId': clientId,
      'reference': Project.projectRef,
      //'image': image
    });
    return response;
  }

  Future<http.Response> getSingleOrder(id) async {
    final response = await http.get(Uri.parse('$_GetOrderByID / $id'));
    return response;
  }

  Future<http.Response> deleteOrder(id) async {
    final response = await http.delete(Uri.parse(_DeleteOrder));
    return response;
  }
}
