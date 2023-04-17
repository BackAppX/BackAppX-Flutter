library backappx;

import 'project.dart';
import 'package:http/http.dart' as http;

class Category {
  static final Category _instance = Category._internal();

  factory Category() {
    return _instance;
  }

  Category._internal();
}
