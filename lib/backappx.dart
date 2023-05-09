library backappx;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

class BackAppX {
  static final BackAppX _instance = BackAppX._internal(); // singleton

  factory BackAppX() {
    return _instance; // return the same object
  }

  BackAppX._internal(); // private constructor

  /**********************************************************************************************************/
  /************************************* Project Management ***********************************************/
  /// ********************************************************************************************************/

  static const String projectRef =
      ''; // this is the project reference that you get from the dashboard
  static const String stripeKey =
      ''; //this is the stripe key that you get from the dashboard
  static const String _baseUrl = 'http://localshost:9092';

  /********************************************************************************************************/
  //*************************************** Client Auth ***************************************************/
  /// ******************************************************************************************************/

  static const _registerUrl = '$_baseUrl/client/client';
  static const _loginUrl = '$_baseUrl/client/login';
  static const _editClientUrl = '$_baseUrl/client/client';
  static const _getClientUrl = '$_baseUrl/client/clientbyid';
  static const _forgetPasswordUrl = '$_baseUrl/client/clientforgot-password';

  Future<http.Response> register(
      name, familyName, email, phoneNumber, password) async {
    final response = await http.post(Uri.parse(_registerUrl), body: {
      'name': name,
      'familyName': familyName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'reference': BackAppX.projectRef
    });
    if (projectRef == null) {
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
      'reference': projectRef,
      'image': image
    });
    if (projectRef == null) {
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

  /********************************************************************************************************/
  /************************************* Category Management ***********************************************/
  /// ******************************************************************************************************/

  static const _deleteCategorie = '$_baseUrl/categorie/:CategorieID';
  static const _addCategorie = '$_baseUrl/categorie/Addproduct';

  static Future<http.Response> deleteCategorie(id) async {
    final response = await http.delete(Uri.parse(_deleteCategorie));
    return response;
  }

  static Future<http.Response> addCategorie(name) async {
    final response = await http.post(Uri.parse(_addCategorie), body: {
      'name': name,
    });
    return response;
  }

  Future<http.Response> addCategoryToProduct(
      String productId, String categoryId) async {
    const String baseUrl = 'http://localhost:9092';
    final String endpoint = '/product/$productId/category';
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.post(
        url,
        body: {'categoryId': categoryId},
      );
      return response;
    } catch (error) {
      return Future.value(http.Response('Error', 500));
    }
  }

  /********************************************************************************************************/
  /************************************* File Storage Management *******************************************/
  /// ******************************************************************************************************/

  static const String _addFileUrl = '$_baseUrl/project/upload';
  static const String _getFilesUrl = '$_baseUrl/project/images';
  static const String _getSingleFileUrl = '$_baseUrl/project/file';
  static const String _deleteFileUrl = '$_baseUrl/project/image';

  static Future<http.Response> addFile(File file, projectId) async {
    final stream = http.ByteStream(file.openRead());
    final length = await file.length();
    final uri = Uri.parse('$_addFileUrl/$projectId');
    final request = http.MultipartRequest('PUT', uri);
    final multipartFile = http.MultipartFile('file', stream, length,
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

  /********************************************************************************************************/
  /************************************* Order Management ***********************************************/
  /// ******************************************************************************************************/

  static const _getOrder = '$_baseUrl/order/orders';
  static const _addOrder = '$_baseUrl/order/addorder';
  static const _getOrderByID = '$_baseUrl/order/:orderId';
  static const _deleteOrder = '$_baseUrl/order/:orderId';

  Future<http.Response> getOrder(id) async {
    final response = await http.get(Uri.parse(_getOrder));
    return response;
  }

  Future<http.Response> addOrder(quantity, productId, clientId) async {
    final response = await http.post(Uri.parse(_addOrder), body: {
      'quantity': quantity,
      'productId': productId,
      'clientId': clientId,
      'reference': projectRef,
      //'image': image
    });
    return response;
  }

  Future<http.Response> getSingleOrder(id) async {
    final response = await http.get(Uri.parse('$_getOrderByID / $id'));
    return response;
  }

  Future<http.Response> deleteOrder(id) async {
    final response = await http.delete(Uri.parse(_deleteOrder));
    return response;
  }

  /********************************************************************************************************/
  /************************************* Payment Management ***********************************************/
  /// ******************************************************************************************************/

  static const _pay = '$_baseUrl/paymentService/pay';

  Future<http.Response> pay(orderId, cardElementId) async {
    final response = await http.post(Uri.parse(_pay), headers: {
      'stripekey':
          stripeKey, //this is the stripe key that you get from the dashboard
    }, body: {
      'orderId':
          orderId, //this orderId is the id of the order returned by the order
      "payment_method":
          cardElementId, //this cardElementId is the id of the card element returned by stripe from cardElement.create()
      "confirmation_method":
          "manual", //this is the confirmation method of the payment
      'reference': projectRef, //this is the reference of the project
    });
    if (stripeKey == null) {
      return http.Response('Please set the stripe key', 400);
    }
    return response;
  }

/********************************************************************************************************/
/************************************* Product Management ***********************************************/
  /// ******************************************************************************************************/

  static const _getproduct = '$_baseUrl/product/products';
  static const _getSingleProduct = '$_baseUrl/product';
  static const _updateProduct = '$_baseUrl/product/:productId';
  static const _deleteProduct = '$_baseUrl/product/:productId';
  static const _addProduct = '$_baseUrl/product/Addproduct';

  Future<http.Response> getProduct(id) async {
    final response = await http.get(Uri.parse(_getproduct));
    return response;
  }

  Future<http.Response> getSingleProduct(id) async {
    final response = await http.get(Uri.parse('$_getSingleProduct/$id'));
    return response;
  }

  Future<http.Response> editProduct(name, price, quantity) async {
    final response = await http.put(Uri.parse(_updateProduct), body: {
      'name': name,
      'price': price,
      'quantity': quantity,
      'reference': projectRef,
      //'image': image
    });

    return response;
  }

  Future<http.Response> deleteProduct(id) async {
    final response = await http.delete(Uri.parse(_deleteProduct));

    return response;
  }

  Future<http.Response> addProduct(quantity, product, client) async {
    final response = await http.post(Uri.parse(_addProduct), body: {
      'quantity': quantity,
      'product': product,
      'client': client,
      'reference': projectRef,
      //'image': image
    });
    return response;
  }
}
