library backappx;

import 'project.dart';
import 'package:http/http.dart' as http;

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
