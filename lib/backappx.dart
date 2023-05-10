library backappx;

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class BackAppX {
  static final BackAppX _instance = BackAppX._internal(); // singleton

  factory BackAppX() {
    return _instance; // return the same object
  }

  BackAppX._internal(); // private constructor

  /**********************************************************************************************************/
  /************************************* Project Management *************************************************/
  /// *******************************************************************************************************/

  static const String projectRef =
      ''; // this is the project reference that you get from the dashboard
  static const String stripeKey =
      ''; //this is the stripe key that you get from the dashboard
  //static const String _baseUrl = 'http://localshost:9092';
  static const String _baseUrl = ''; // this is the base url of the backend api

  /********************************************************************************************************/
  //*************************************** Client Auth ***************************************************/
  /// *****************************************************************************************************/

  static const _registerUrl =
      '$_baseUrl/client/client'; // register url of the api backend
  static const _loginUrl =
      '$_baseUrl/client/login'; // login url of the api backend
  static const _editClientUrl =
      '$_baseUrl/client/client'; // edit client url of the api backend
  static const _getClientUrl =
      '$_baseUrl/client/clientbyid'; // get client url of the api backend
  static const _forgetPasswordUrl =
      '$_baseUrl/client/clientforgot-password'; // forget password url of the api backend

  // register function that takes the client name, family name, email, phone number and password
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
    if (projectRef.isEmpty) {
      return http.Response('Please set the project reference', 400);
    }

    return response;
  }

  // login function that takes the client email and password
  Future<http.Response> login(email, password) async {
    final response = await http.post(Uri.parse(_loginUrl), body: {
      'email': email,
      'password': password,
    });

    return response;
  }

  // edit profile function that takes the client id, name, family name, email, phone number and password
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
    if (projectRef.isEmpty) {
      return http.Response('Please set the project reference', 400);
    }

    return response;
  }

  // get client function that takes the client id
  Future<http.Response> getClient(id) async {
    final response = await http.get(Uri.parse('$_getClientUrl/$id'));
    return response;
  }

  // forget password function that takes the client email
  Future<http.Response> forgetPassword(email) async {
    final response = await http.put(Uri.parse(_forgetPasswordUrl), body: {
      'email': email,
    });
    return response;
  }

  /********************************************************************************************************/
  /************************************* Category Management **********************************************/
  /// *****************************************************************************************************/

  static const _deleteCategorie =
      '$_baseUrl/categorie/:CategorieID'; // delete categorie url of the api backend
  static const _addCategorie =
      '$_baseUrl/categorie/Addproduct'; // add categorie url of the api backend

  // delete categorie function that takes the categorie id
  static Future<http.Response> deleteCategorie(id) async {
    final response = await http.delete(Uri.parse(_deleteCategorie));
    return response;
  }

  // add categorie function that takes the categorie name
  static Future<http.Response> addCategorie(name) async {
    final response = await http.post(Uri.parse(_addCategorie), body: {
      'name': name,
    });
    return response;
  }

  // add categorie to product function that takes the product id and the categorie id
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

  static const String _addFileUrl =
      '$_baseUrl/project/upload'; // add file url of the api backend
  static const String _getFilesUrl =
      '$_baseUrl/project/images'; // get files url of the api backend
  static const String _getSingleFileUrl =
      '$_baseUrl/project/file'; // get single file url of the api backend
  static const String _deleteFileUrl =
      '$_baseUrl/project/image'; // delete file url of the api backend

  // add file function that takes the file and the project id
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

  // get files function that takes the project id
  static Future<http.Response> getFiles(projectId) async {
    final response = await http.get(Uri.parse("$_getFilesUrl/$projectId"));
    if (response.statusCode == 200) {
      final responseBody = json.encode(response.body);
      return http.Response(responseBody, response.statusCode);
    } else {
      throw Exception('Failed to get files:${response.statusCode}');
    }
  }

  // get single file function that takes the project id and the image name
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

  // delete file function that takes the project id and the image name
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

  static const _getOrder =
      '$_baseUrl/order/orders'; // get order url of the api backend
  static const _addOrder =
      '$_baseUrl/order/addorder'; // add order url of the api backend
  static const _getOrderByID =
      '$_baseUrl/order/:orderId'; // get order by id url of the api backend
  static const _deleteOrder =
      '$_baseUrl/order/:orderId'; // delete order url of the api backend

  // get order function that takes the order id
  Future<http.Response> getOrder(id) async {
    final response = await http.get(Uri.parse(_getOrder));
    return response;
  }

  // add order function that takes the quantity, the product id and the client id
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

  // get order by id function that takes the order id
  Future<http.Response> getSingleOrder(id) async {
    final response = await http.get(Uri.parse('$_getOrderByID / $id'));
    return response;
  }

  // delete order function that takes the order id
  Future<http.Response> deleteOrder(id) async {
    final response = await http.delete(Uri.parse(_deleteOrder));
    return response;
  }

  /********************************************************************************************************/
  /************************************* Payment Management ***********************************************/
  /// ******************************************************************************************************/

  static const _pay =
      '$_baseUrl/paymentService/pay'; // pay url of the api backend

  // pay function that takes the order id and the card element id
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
    if (stripeKey.isEmpty) {
      return http.Response('Please set the stripe key', 400);
    }
    return response;
  }

/********************************************************************************************************/
/************************************* Product Management ***********************************************/
  /// ******************************************************************************************************/

  static const _getproduct =
      '$_baseUrl/product/products'; // get product url of the api backend
  static const _getSingleProduct =
      '$_baseUrl/product'; // get single product url of the api backend
  static const _updateProduct =
      '$_baseUrl/product/:productId'; // update product url of the api backend
  static const _deleteProduct =
      '$_baseUrl/product/:productId'; // delete product url of the api backend
  static const _addProduct =
      '$_baseUrl/product/Addproduct'; // add product url of the api backend

  // get product function that takes the product id
  Future<http.Response> getProduct(id) async {
    final response = await http.get(Uri.parse(_getproduct));
    return response;
  }

  // get single product function that takes the product id
  Future<http.Response> getSingleProduct(id) async {
    final response = await http.get(Uri.parse('$_getSingleProduct/$id'));
    return response;
  }

  // update product function that takes the product name, the product price and the product quantity
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

  // delete product function that takes the product id
  Future<http.Response> deleteProduct(id) async {
    final response = await http.delete(Uri.parse(_deleteProduct));

    return response;
  }

  // add product function that takes the product quantity, the product id and the client id
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
