library backappx;
import 'package:http/http.dart' as http;


//here you can add your own variables

class BackAppX {
  static Auth auth = Auth();
  static User user = User();
}


class Auth {
  static const String _baseUrl = 'http://localhost:9092/';
  static const _loginUrl = '$_baseUrl/login';
  static const String _registerUrl = '$_baseUrl/register';
  static bool login(email, password) {
    http.post(Uri.parse(_loginUrl), body: {
      'email': email,
      'password': password,
    }).then((response) {
      if (response.statusCode == 200) {
        print('login success');
        return true;
      } else {
        print('login failed');
        return false;
      }

    });
    return false;

  }

  static void register(name, email, password) {
    print('register');
    //post request to server
  }


}

class User {
  static const String _baseUrl = 'http://localhost:8000/api';
  static const String _userUrl = '$_baseUrl/user';
  static void getUser() {
    print('get user');
    //get request to server
  }

  static void updateUser() {
    print('update user');
    //put request to server
  }

  static void deleteUser() {
    print('delete user');
    //delete request to server
  }
}
