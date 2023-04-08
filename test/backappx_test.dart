import 'package:flutter_test/flutter_test.dart';
import 'package:backappx/backappx.dart';


void main() {
  group('Auth', ()
  {
    print("--------------------------------------------------------------");
    print("----------------------- Auth Class ---------------------------");
    print("--------------------------------------------------------------");


    test('login should return a response with status code 200', () async {
      // Set up
      final email = 'karamelmannai@gmail.com';
      final password = '123456';

      // Act
      final result = await Auth.login(email, password);
      // Assert
      expect(result.statusCode, 200);
    });

    test('register should return a response with status code 200', () async {
      // Set up
      final name = 'Kareem';
      final email = '';
      final phone = 24545554;
      final password = '123456';

      //Act
      final result = await Auth.register(name, email,password);

      //Assert
      expect(result.statusCode, 200);
    });


  });
}

