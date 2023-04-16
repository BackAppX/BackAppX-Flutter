library backappx;

import 'package:http/http.dart' as http;

class BackAppX {
  static const projectRef = '';

  // here you can add more static classes
  static Auth auth = Auth();
  static Product product = Product();
  static Order order = Order();
  static Categorie categorie = Categorie();
}

class Auth {
  // here you can add routes for your auth class
  static final String _baseUrl = 'http://localhost:9092/client';

  static final _registerUrl = '$_baseUrl/client';
  static final _loginUrl = '$_baseUrl/login';
  static final _editClientUrl = '$_baseUrl/client/:id';
  static final _getClientUrl = '$_baseUrl/clientbyid/:id';
  static final _forgetPasswordUrl = '$_baseUrl/clientforgot-password';
  static final _resetPasswordUrl = '$_baseUrl/clientresetpassword';

  static Future<http.Response> register(
      name, familyName, email, phoneNumber, password) async {
    final response = await http.post(Uri.parse(_registerUrl), body: {
      'name': name,
      'familyName': familyName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'reference': BackAppX.projectRef
    });
    print(response.body);
    return response;
  }

  static Future<http.Response> login(email, password) async {
    final response = await http.post(Uri.parse(_loginUrl), body: {
      'email': email,
      'password': password,
    });
    print(response.body);
    return response;
  }

  static Future<http.Response> editProfile(
      name, familyName, fullName, email, phoneNumber, password, image) async {
    final response = await http.put(Uri.parse(_editClientUrl), body: {
      'name': name,
      'familyName': familyName,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'reference': BackAppX.projectRef,
      'image': image
    });

    print(response.body);
    return response;
  }

  static Future<http.Response> getClient(id) async {
    final response = await http.get(Uri.parse('$_getClientUrl/$id'));

    print(response.body.toString());
    return response;
  }

  static Future<http.Response> forgetPassword(email) async {
    final response = await http.post(Uri.parse(_forgetPasswordUrl), body: {
      'email': email,
    });
    print(response.body.toString());
    return response;
  }

  static Future<http.Response> resetPassword(password, token) async {
    final response = await http.post(Uri.parse(_resetPasswordUrl), body: {
      'newPass': password,
      'resetLink': token,
    });

    return response;
  }
}

class Order {
  // here you can add routes for your auth class
  static final String _baseUrl = 'http://localhost:9092/order';

  static final _GetOrder = '$_baseUrl/orders';
  static final _AddOrder = '$_baseUrl/addorder';
  static final _GetOrderByID = '$_baseUrl/:orderId';
  static final _DeleteOrder = '$_baseUrl/:orderId';

  static Future<http.Response> getOrder(id) async {
    final response = await http.get(Uri.parse(_GetOrder));

    print(response.body.toString());
    return response;
  }

  static Future<http.Response> addOrder(quantity, productId, clientId) async {
    final response = await http.post(Uri.parse(_AddOrder), body: {
      'quantity': quantity,
      'productId': productId,
      'clientId': clientId,
      //'reference': BackAppX.projectRef,
      //'image': image
    });
    print(response.body);
    return response;
  }

  static Future<http.Response> getSingleOrder(id) async {
    final response = await http.get(Uri.parse('$_GetOrderByID / $id'));

    print(response.body.toString());
    return response;
  }

  static Future<http.Response> deleteOrder(id) async {
    final response = await http.delete(Uri.parse(_DeleteOrder));

    print(response.body.toString());
    return response;
  }
}

class Product {
  // here you can add routes for your auth class
  static final String _baseUrl = 'http://localhost:9092/product';

  static final _Getproduct = '$_baseUrl/products';
  static final _getSingleProduct = '$_baseUrl/:productId';
  static final _UpdateProduct = '$_baseUrl/:productId';
  static final _DeleteProduct = '$_baseUrl/:productId';
  static final _addProduct = '$_baseUrl/Addproduct';

  static Future<http.Response> getProduct(id) async {
    final response = await http.get(Uri.parse(_Getproduct));

    print(response.body.toString());
    return response;
  }

  static Future<http.Response> getSingleProduct(id) async {
    final response = await http.get(Uri.parse('$_getSingleProduct / $id'));

    print(response.body.toString());
    return response;
  }

  static Future<http.Response> editProduct(name, price, quantity) async {
    final response = await http.put(Uri.parse(_UpdateProduct), body: {
      'name': name,
      'price': price,
      'quantity': quantity,
      //'reference': BackAppX.projectRef,
      //'image': image
    });

    print(response.body);
    return response;
  }

  static Future<http.Response> deleteProduct(id) async {
    final response = await http.delete(Uri.parse(_DeleteProduct));

    print(response.body.toString());
    return response;
  }

  static Future<http.Response> addProduct(quantity, product, client) async {
    final response = await http.post(Uri.parse(_addProduct), body: {
      'quantity': quantity,
      'product': product,
      'client': client,
      //'reference': BackAppX.projectRef,
      //'image': image
    });
    print(response.body);
    return response;
  }
}

class Categorie {
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
