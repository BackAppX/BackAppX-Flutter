library backappx;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

class Auth {
  static final _baseUrl = 'http://localhost:9092/client';
  static final _registerUrl = '$_baseUrl/client';
  static final _loginUrl = '$_baseUrl/login';
  static final _editClientUrl = '$_baseUrl/client';
  static final _getClientUrl = '$_baseUrl/clientbyid';
  static final _forgetPasswordUrl = '$_baseUrl/clientforgot-password';


  static final Auth _instance = Auth._internal();

  factory Auth() {
    return _instance;
  }

  Auth._internal();

  Future<http.Response> register(

      name, familyName, email, phoneNumber, password) async {
    final response = await http.post(Uri.parse(_registerUrl), body: {
      'name': name,
      'familyName': familyName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'reference': Project.projectRef
    });
    if (Project.projectRef == null) {
      return http.Response('Please set the project reference', 400);
    }

    return response;
  }

  Future<http.Response> login(email, password) async {
    final response = await http.post(Uri.parse(_loginUrl), body: {
      'email': email,
      'password': password,
    });


    return response;
  }

  Future<http.Response> editProfile(
      id, name, familyName, email, phoneNumber, password, image) async {
    final response = await http.put(Uri.parse('$_editClientUrl/$id'), body: {
      'name': name,
      'familyName': familyName,
      'fullName': name + ' ' + familyName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'reference': Project.projectRef,
      'image': image
    });
    if (Project.projectRef == null) {
      return http.Response('Please set the project reference', 400);
    }

    return response;
  }

  Future<http.Response> getClient(id) async {
    final response = await http.get(Uri.parse('$_getClientUrl/$id'));
    return response;
  }

  Future<http.Response> forgetPassword(email) async {
    final response = await http.put(Uri.parse(_forgetPasswordUrl), body: {
      'email': email,
    });
    return response;
  }
}

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

class FileStorage {
  static final FileStorage _instance = FileStorage._internal();

  factory FileStorage() {
    return _instance;
  }

  FileStorage._internal();

  static const String _baseUrl = 'http://localhost:9092/project';
  static const String _addFileUrl = '$_baseUrl/upload';
  static const String _getFilesUrl = '$_baseUrl/images';
  static const String _getSingleFileUrl = '$_baseUrl/file';
  static const String _deleteFileUrl = '$_baseUrl/image';

  static Future<http.Response> addFile(File file, projectId) async {
    final stream = new http.ByteStream(file.openRead());
    final length = await file.length();
    final uri = Uri.parse('$_addFileUrl/$projectId');
    final request = new http.MultipartRequest('PUT', uri);
    final multipartFile = new http.MultipartFile('file', stream, length,
        filename: path.basename(file.path));
    request.files.add(multipartFile);
    final response = await request.send();
    return http.Response.fromStream(response);
  }

  static Future<http.Response> getFiles(projectId) async {
    final response = await http.get(Uri.parse("$_getFilesUrl/$projectId"));
    if (response.statusCode == 200) {
      final responseBody = json.encode(response.body);
      return http.Response(responseBody, response.statusCode);
    } else {
      throw Exception('Failed to get files:${response.statusCode}');
    }
  }

  static Future<http.Response> getFile(projectId, imageName) async {
    final response =
        await http.get(Uri.parse("$_getSingleFileUrl/$projectId/$imageName"));
    if (response.statusCode == 200) {
      final responseBody = json.encode(response.body);
      return http.Response(responseBody, response.statusCode);
    } else {
      throw Exception('Failed to get files:${response.statusCode}');
    }
  }

  static Future<http.Response> deleteFile(projectId, imageName) async {
    final response =
        await http.delete(Uri.parse('$_deleteFileUrl/$projectId/$imageName'));
    if (response.statusCode == 200) {
      final responseBody = json.encode(response.body);
      return http.Response(responseBody, response.statusCode);
    } else {
      throw Exception('Failed to get files:${response.statusCode}');
    }
  }
}

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

class Payment {
  static final _baseUrl = 'http://localhost:9092/paymentService';
  static final _pay = '$_baseUrl/pay';
  static final Payment _instance = Payment._internal();

  factory Payment() {
    return _instance;
  }

  Payment._internal();

  Future<http.Response> pay(orderId, cardElementId) async {
    final response = await http.post(Uri.parse(_pay), headers: {
      'stripekey': Project
          .stripeKey, //this is the stripe key that you get from the dashboard
    }, body: {
      'orderId':
          orderId, //this orderId is the id of the order returned by the order
      "payment_method":
          cardElementId, //this cardElementId is the id of the card element returned by stripe from cardElement.create()
      "confirmation_method":
          "manual", //this is the confirmation method of the payment
      'reference': Project.projectRef, //this is the reference of the project
    });
    if (Project.stripeKey == null) {
      return http.Response('Please set the stripe key', 400);
    }
    return response;
  }
}

class Project {
  static final String projectRef =
      ''; // this is the project reference that you get from the dashboard
  static final String stripeKey =
      ''; //this is the stripe key that you get from the dashboard
  static final Project _instance = Project._internal();
  factory Project() {
    return _instance;
  }
  Project._internal();
}

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
