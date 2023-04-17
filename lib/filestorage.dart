library backappx;

//TODO: rakah zokomou
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

class FileStorage {
  static const String _baseUrl = 'http://localhost:9092/project';
  static const String _addFileUrl = '$_baseUrl/upload';
  static const String _getFilesUrl = '$_baseUrl/images';
  static const String _getSingleFileUrl = '$_baseUrl/file';
  static const String _deleteFileUrl = '$_baseUrl/image';

  static Future<http.Response> addFile(File file, projectId) async {
    final stream = new http.ByteStream(file.openRead());
    final length = await file.length();
    final uri = Uri.parse('$_addFileUrl/$projectId');
    final request = new http.MultipartRequest('PUT', uri);
    final multipartFile = new http.MultipartFile('file', stream, length,
        filename: path.basename(file.path));
    request.files.add(multipartFile);
    final response = await request.send();
    return http.Response.fromStream(response);
  }

  static Future<http.Response> getFiles(projectId) async {
    final response = await http.get(Uri.parse("$_getFilesUrl/$projectId"));
    if (response.statusCode == 200) {
      final responseBody = json.encode(response.body);
      return http.Response(responseBody, response.statusCode);
    } else {
      throw Exception('Failed to get files:${response.statusCode}');
    }
  }

  static Future<http.Response> getFile(projectId, imageName) async {
    final response =
        await http.get(Uri.parse("$_getSingleFileUrl/$projectId/$imageName"));
    if (response.statusCode == 200) {
      final responseBody = json.encode(response.body);
      return http.Response(responseBody, response.statusCode);
    } else {
      throw Exception('Failed to get files:${response.statusCode}');
    }
  }

  static Future<http.Response> deleteFile(projectId, imageName) async {
    final response =
        await http.delete(Uri.parse('$_deleteFileUrl/$projectId/$imageName'));
    if (response.statusCode == 200) {
      final responseBody = json.encode(response.body);
      return http.Response(responseBody, response.statusCode);
    } else {
      throw Exception('Failed to get files:${response.statusCode}');
    }
  }

  /*
  static Future<Map<String, dynamic>> getOrder(orderId) async {
    final response = await http.get(Uri.parse('$_baseUrl/$orderId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get order:${response.body}');
    }
    //get request to server
  }

  static Future<String> deleteOrder(orderId) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$orderId'));
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      return decodedResponse['message'];
    } else {
      throw Exception('Failed to get order:${response.body}');
    }
  }

  static void updateOrder() {
    print('update order');
    //put request to server
  }

  static void payOrder() {
    print('pay order');
    //post request to server
  }

   */
}
