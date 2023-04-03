library backappx;
import 'package:http/http.dart' as http;


class BackAppX {
  // static const projectID = '5f9f9f9f9f9f9f9f9f9f9f9f';
  static Auth auth = Auth();
}

class Auth {
  static const String _baseUrl = 'http://localhost:9092/user';
  static const _loginUrl = '$_baseUrl/login';

  static Future<bool> login(email, password) async {
    final response = await http.post(Uri.parse(_loginUrl), body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      print('login success');
      print("----------------------------------");
      print("${response.body}");
      print("----------------------------------");

      return true;
    } else {
      print('login failed');
      print("----------------------------------");
      print("${response.body}");
      print("----------------------------------");

      return false;
    }
  }
}

// static const String _registerUrl = '$_baseUrl/register';

// static User user = User();
// static Product product = Product();
// static Order order = Order();


//   static void register(name, email, password) {
//     print('register');
//     //post request to server
//   }
//
//
// }
//
// class User {
//   static const String _baseUrl = 'http://localhost:8000/api';
//   static const String _userUrl = '$_baseUrl/user';
//   static void getUser() {
//     print('get user');
//     //get request to server
//   }
//
//   static void updateUser() {
//     print('update user');
//     //put request to server
//   }
//
//   static void deleteUser() {
//     print('delete user');
//     //delete request to server
//   }
// }
//
// class Product {
//   static const String _baseUrl = 'http://localhost:8000/api';
//   static const String _productUrl = '$_baseUrl/product';
//   static void getProduct() {
//     print('get product');
//     //get request to server
//   }
//
//   static void updateProduct() {
//     print('update product');
//     //put request to server
//   }
//
//   static void deleteProduct() {
//     print('delete product');
//     //delete request to server
//   }
// }
//
// class Order {
//   static const String _baseUrl = 'http://localhost:8000/api';
//   static const String _orderUrl = '$_baseUrl/order';
//   static void getOrder() {
//     print('get order');
//     //get request to server
//   }
//
//   static void updateOrder() {
//     print('update order');
//     //put request to server
//   }
//
//   static void deleteOrder() {
//     print('delete order');
//     //delete request to server
//   }
//   static void createOrder() {
//     print('create order');
//     //post request to server
//   }
//
//   static void getOrders() {
//     print('get orders');
//     //get request to server
//   }
//   static void payOrder() {
//     print('pay order');
//     //post request to server
//   }

