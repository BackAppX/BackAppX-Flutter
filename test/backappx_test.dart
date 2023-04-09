import 'package:flutter_test/flutter_test.dart';
import 'package:backappx/backappx.dart';


void main() {
  BackAppX.projectRef = '5f9f1b0b0b9b8c0017a5e1d1';
  group('Auth', ()
  {
    print("--------------------------------------------------------------");
    print("-------------------- Auth Module Test ------------------------");
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

    test('register should return a response with status code 201', () async {
      print("                                                              ");
      print("                                                              ");
      print("--------------------------------------------------------------");
      print("----------------------- Register Test ------------------------");
      print("--------------------------------------------------------------");
      print("                                                              ");
      print("                                                              ");

      // Set up
      final name = 'Kareem';
      final familyName = 'karamù';
      final email = 'Karammannai3@gmail.com';
      final phone = '24545554';
      final password = '123456';

      //Act
      final result = await Auth.register(name,familyName, email, phone, password);

      //Assert
      expect(result.statusCode, 201);
    });
    test('editProfile should return a response with status code 201', () async {
      print("                                                              ");
      print("                                                              ");
      print("--------------------------------------------------------------");
      print("----------------------- Edit Profile Test --------------------");
      print("--------------------------------------------------------------");
      print("                                                              ");
      print("                                                              ");

      // Set up
      final id = '6419a598640a218c87833131';
      final name = 'Kareem';
      final familyName = 'ùpdatedSDK';
      final fullName = 'Kareem ùpdatedSDK';
      final email = 'karam.mannai@esprit.tn';
      final phone = '24545554';
      final password= '123456';
      final image = '';

      //Act
      final result = await Auth.editProfile(id, name, familyName,fullName, email,phone,password,image);

      //Assert
      expect(result.statusCode, 201);
    });

    test(" getClient should return a response with status code 200", () async {
      print("                                                              ");
      print("                                                              ");
      print("--------------------------------------------------------------");
      print("----------------------- Get Client Test ------------------------");
      print("--------------------------------------------------------------");
      print("                                                              ");
      print("                                                              ");

      // Set up
      final id = '6419a598640a218c87833131';

      //Act
      final result = await Auth.getClient(id);

      //Assert
      expect(result.statusCode, 200);
    });

    test(" forgetPassword should return a response with status code 200", () async {
      print("                                                              ");
      print("                                                              ");
      print("--------------------------------------------------------------");
      print("--------------------- Forget Password Test -------------------");
      print("--------------------------------------------------------------");
      print("                                                              ");
      print("                                                              ");

      // Set up
      final email = 'karam.mannai@esprit.tn';

      //Act
      final result = await Auth.forgetPassword(email);

      //Assert
      expect(result.statusCode, 200);
    });

     // test(" resetPassword should return a response with status code 200", () async {
     //  print("--------------------------------------------------------------");
     //  print("--------------------- Reset Password Test -------------------");
     //  print("--------------------------------------------------------------");
     //  print("                                                              ");
     //  print("                                                              ");
     //
     //  // Set up
     //  final password = "123456";
     //  final token = "5f9f1b0b0b9b8c0017a5e1d1";
     //
     //  //Act
     //  final result = await Auth.resetPassword(password, token);
     //
     //  //Assert
     //  expect(result.statusCode, 200);
     //
     // });

  });
}

