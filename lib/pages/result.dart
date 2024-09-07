import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:track_viewer/constants.dart';
import 'dart:convert';

class ResultPage extends StatefulWidget {
  final Map arguments;
  const ResultPage({super.key, required this.arguments});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Future<void> initState() async {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> details = await getDetails(widget.arguments["href"]);
  }

  Future<Map<String, dynamic>> getDetails(String href) async {
    Map<String, String> queryParameters = Uri.parse(href).queryParameters;
    String uuid = queryParameters["uuid"]!;
    String uriPath = kDetailsPath + uuid;
    Uri uri = Uri(
      scheme: kDetailsScheme,
      host: kDetailsHost,
      path: uriPath,
    );
    Response response = await get(uri);
    Map<String, dynamic> details = {};
    if (response.statusCode == 200) {
      details = json.decode(response.body);
    } else {
      print(response.statusCode);
    }
    return details;
  }

  List<Map<String, dynamic>> getReviewEvents(Map<String, dynamic> details) {
    List<Map<String, dynamic>> reviewEvents = details["ReviewEvents"];

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("解析结果"),
      ),
      body: const Center(
        child: Text("解析结果页面"),
      ),
    );
  }
}
