library backappx;

import 'package:http/http.dart' as http;

class FileStorage {
  static final String _baseUrl = 'http://localhost:9092/file';

  static final FileStorage _instance = FileStorage._internal();

  factory FileStorage() {
    return _instance;
  }

  FileStorage._internal();


}