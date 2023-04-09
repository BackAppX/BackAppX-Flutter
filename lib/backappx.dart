library backappx;
import 'package:http/http.dart' as http;


class BackAppX {
  static late String projectRef ;
  // here you can add more static classes
  static Auth auth = Auth();
  static Product product = Product();
  static Order order = Order();
}

class Auth {
  // here you can add routes for your auth class
  static final String _baseUrl = 'http://localhost:9092/client';

  static final _registerUrl = '$_baseUrl/client';
  static final _loginUrl = '$_baseUrl/login';
  static final _editClientUrl = '$_baseUrl/client';
  static final _getClientUrl = '$_baseUrl/clientbyid';
  static final _forgetPasswordUrl = '$_baseUrl/clientforgot-password';
  static final _resetPasswordUrl = '$_baseUrl/clientresetpassword';

  static Future<http.Response> register(name,familyName, email, phoneNumber, password) async {
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

  static Future<http.Response> editProfile(id, name, familyName,fullName, email,phoneNumber,password,image) async {
    final response = await http.put(Uri.parse('$_editClientUrl/$id'), body: {
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
    final response = await http.put(Uri.parse(_forgetPasswordUrl), body: {
      'email': email,
    });
    print(response.body.toString());
    return response;
  }

  static Future<http.Response> resetPassword(password,token) async {
    final response = await http.put(Uri.parse(_resetPasswordUrl), body: {
      'newPass': password,
      'resetLink': token,
    });
    print(response.body.toString());
    return response;
  }
}

class Product {}
class Order {}


