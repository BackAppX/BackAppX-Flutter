import 'package:flutter_test/flutter_test.dart';
import 'package:backappx/project.dart';
import 'package:backappx/auth.dart';


void main() {
  Project.projectRef = '5f9f1b0b0b9b8c0017a5e1d1';

  Auth auth = Auth();

  group('Auth', ()
  {
    print("--------------------------------------------------------------");
    print("-------------------- Auth Module Test ------------------------");
    print("--------------------------------------------------------------");
    print("                                                              ");
    print("                                                              ");

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
      final familyName = 'karam';
      final email = 'Karamelmannain@gmail.com';
      final phone = '24545554';
      final password = '123456';

      //Act
      final result = await auth.register(name, familyName, email, phone, password);

      //Assert
      expect(result.statusCode, 201);
    });

    test('login should return a response with status code 200', () async {
      print("--------------------------------------------------------------");
      print("----------------------- Login Test ---------------------------");
      print("--------------------------------------------------------------");
      print("                                                              ");
      print("                                                              ");

      // Set up
      final email = 'Karamelmannain@gmail.com';
      final password = '123456';

      // Act
      final result = await auth.login(email, password);
      // Assert
      expect(result.statusCode, 200);
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
      final id = '6419a579640a218c8783312e';
      final name = 'Kareem';
      final familyName = 'ùpdatedSDK';
      final fullName = 'Kareem ùpdatedSDK';
      final email = 'karam.mannai@esprit.tn';
      final phone = '24545554';
      final password= '123456';
      final image = '';

      //Act
      final result = await auth.editProfile(id, name, familyName,fullName, email,phone,password,image);

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
      final id = '6419a579640a218c8783312e';

      //Act
      final result = await auth.getClient(id);

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
        final result = await auth.forgetPassword(email);

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
     //  final token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDE5YTU5ODY0MGEyMThjODc4MzMxMzEiLCJpYXQiOjE2ODExMzAwNTQsImV4cCI6MTY4MTEzMTI1NH0.BxZSm_jWTLFMfImuK6G0itfvbgCzlQqRLLN9GcCXtTI";
     //  //Act
     //  final result = await Auth.resetPassword(password, token);
     //
     //  //Assert
     //  expect(result.statusCode, 200);
     //
     // });

  });
}

