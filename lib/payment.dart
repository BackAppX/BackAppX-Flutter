library backappx;

import 'package:backappx/product.dart';

import 'project.dart';
import 'package:http/http.dart' as http;

class Payment {
  static final _baseUrl = 'http://localhost:9092/paymentService';
  static final _pay = '$_baseUrl/pay';
  static final Payment _instance = Payment._internal();

  factory Payment() {
    return _instance;
  }

  Payment._internal();

  Future<http.Response> pay(orderId, cardElementId) async {
    final response = await http.post(Uri.parse(_pay), headers: {
      'stripekey':
          Project.stripeKey, //this is the stripe key that you get from the dashboard
    }, body: {
      'orderId':
          orderId, //this orderId is the id of the order returned by the order
      "payment_method":
          cardElementId, //this cardElementId is the id of the card element returned by stripe from cardElement.create()
      "confirmation_method":
          "manual", //this is the confirmation method of the payment
      'reference': Project.projectRef, //this is the reference of the project
    });
    if (Project.stripeKey == null) {
      return http.Response('Please set the stripe key', 400);
    }
    return response;
  }
}
