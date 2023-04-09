import 'package:flutter_test/flutter_test.dart';
import 'package:backappx/backappx.dart';


void main() {
  group('Auth', ()
  {
    print("--------------------------------------------------------------");
    print("----------------------- Auth Class ---------------------------");
    print("--------------------------------------------------------------");
    print("                                                              ");
    print("                                                              ");

    test('login should return a response with status code 200', () async {
      print("--------------------------------------------------------------");
      print("----------------------- Login Test ---------------------------");
      print("--------------------------------------------------------------");
      print("                                                              ");
      print("                                                              ");
      // Set up
      final email = 'Karammannai@gmail.com';
      final password = '123456';

      // Act
      final result = await Auth.login(email, password);
      // Assert
      expect(result.statusCode, 200);
    });



    test('register should return a response with status code 200', () async {
      print("--------------------------------------------------------------");
      print("----------------------- Register Test ------------------------");
      print("--------------------------------------------------------------");
      print("                                                              ");
      print("                                                              ");

      // Set up
      final name = 'Kareem';
      final familyName = 'karamù';
      final email = 'Karammannai@gmail.com';
      final phone = '24545554';
      final password = '123456';

      //Act
      final result = await Auth.register(name,familyName, email, phone, password);

      //Assert
      expect(result.statusCode, 200);
    });


  });
}

