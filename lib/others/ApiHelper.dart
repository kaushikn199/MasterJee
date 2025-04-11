import 'dart:convert';

import '../constants.dart';
import 'package:http/http.dart' as http;

class ApiHelper {

  static const login = 'login';

  static const Map<String, String> defaultHeaders = {
    'Client-Service': "smartschool",
    'Auth-Key': "schoolAdmin@",
    'Content-Type': 'application/json',
  };


  static Future<Map<String, dynamic>> post(
      String endpoint,
      Map<String, dynamic> body, {
        Map<String, String>? customHeaders,
      }) async {
    var url = Uri.parse('$BASE_URL$endpoint');

    print("url : ${url}");

    try {
      final response = await http.post(
        url,
        headers: customHeaders ?? defaultHeaders,
        body: jsonEncode(body),
      );

      print('API POST [$endpoint] => ${response.statusCode}');
      print('Response: ${response.body}');

      final responseData = json.decode(response.body);
      print('responseData: ${responseData}');

      if (response.statusCode == 200) {
        return responseData;
      } else {
        throw Exception(responseData['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      print('API ERROR: $e');
      rethrow;
    }
  }



}
