import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  final Uri uri;
  NetworkHelper({required this.uri});

  Future<Map<String, dynamic>> getData() async {
    Map<String, dynamic> data = {};
    Response response = await get(uri);
    if (response.statusCode == 200) {
      data = json.decode(response.body);
    }
    return data;
  }
}
