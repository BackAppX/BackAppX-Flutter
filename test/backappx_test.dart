import 'package:flutter_test/flutter_test.dart';
import 'package:backappx/backappx.dart';


void main() {
  group('Auth', () {
    test('login should return true when given valid credentials', () async {
      // Set up
      final email = 'karamelmannai@gmail.com';
      final password = '123456';
      // Act
      final result = await Auth.login(email, password);
      // Assert
      expect(result, true);
    });

    test('login should return false when given invalid credentials', () async {
      // Set up
      final email = 'karamelmannai@gmail.com';
      final password = '1234567';
      // Act
      final result = await Auth.login(email, password);
      // Assert
      expect(result, false);
    });

    // test('login should return false when given invalid credentials', () async {
    //   // Set up
    //   final email = 'test@test.com';
    //   final password = 'invalidpassword';
    //
    //   // Act
    //   final result = await Auth.login(email, password);
    //
    //   // Assert
    //   expect(result, false);
    // });

    // test('register should create a new user', () async {
    //   // Set up
    //   final name = 'Test User';
    //   final email = 'test@test.com';
    //   final password = 'test123';
    //
    //   // Act
    //   Auth.register(name, email, password);
    //   final response = await http.get(Uri.parse('http://localhost:9092/user/$email'));
    //
    //   // Assert
    //   expect(response.statusCode, 200);
    // });
  });

  // group('User', () {
  //   test('getUser should return the current user', () {
  //     // Set up
  //
  //     // Act
  //     final result = User.getUser();
  //
  //     // Assert
  //     // expect(result, /* expected result */);
  //   });
  //
  //   test('updateUser should update the current user', () {
  //     // Set up
  //
  //     // Act
  //     User.updateUser();
  //
  //     // Assert
  //     // expect(/* check that user was updated correctly */);
  //   });
  //
  //   // Add more test cases for User class methods
  // });

  // Add test cases for Product and Order classes
}