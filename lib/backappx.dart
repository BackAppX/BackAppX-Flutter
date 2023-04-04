library backappx;
import 'package:http/http.dart' as http;


class BackAppX {
  static const projectRef = '';

  // here you can add more static classes
  static Auth auth = Auth();
}

class Auth {
  // here you can add routes for your auth class
  static const String _baseUrl = 'http://localhost:9092/user';
  static const _loginUrl = '$_baseUrl/login';
  static const _registerUrl = '$_baseUrl/register';
  static const _editUserUrl = '$_baseUrl/editUser';
  static const _getUserUrl = '$_baseUrl/getUser';

  static Future<http.Response> login(email, password) async {
    final response = await http.post(Uri.parse(_loginUrl), body: {
      'email': email,
      'password': password,
    });

    return response;

  }

  static Future<http.Response> register(name, email, password) async {
    final response = await http.post(Uri.parse(_registerUrl), body: {
      'name': name,
      'email': email,
      'password': password,
      'project': BackAppX.projectRef,
    });

    return response;
  }

  static Future<http.Response> editUser(name, email, password) async {
    final response = await http.put(Uri.parse(_editUserUrl), body: {
      'name': name,
      'email': email,
      'password': password,
    });

    return response;
  }

  static Future<http.Response> getUser(id) async {
    final response = await http.get(Uri.parse('$_getUserUrl/$id'));

    return response;
  }
}


