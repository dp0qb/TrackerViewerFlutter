import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:track_viewer/pages/about.dart';
import 'package:track_viewer/pages/settings.dart';
import '../constants.dart';
import '../services/networking.dart';
import './result.dart';

class MiddlePage extends StatefulWidget {
  final Map arguments;
  const MiddlePage({super.key, required this.arguments});

  @override
  State<MiddlePage> createState() => _MiddlePageState();
}

class _MiddlePageState extends State<MiddlePage> {
  Map<String, dynamic> details = {};
  String filePath = "assets/temp_demo_json_files/data.json";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.arguments["href"] == "") {
      // print("null value");
      loadDemoJsonData(filePath);
    } else {
      print(widget.arguments["href"]);
    }
    // loadDemoJsonData(filePath);
    // print(details);
  }

  void loadDemoJsonData(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    details = jsonDecode(jsonString);
    Navigator.pushNamed(context, "/result", arguments: {"details": details});
    // print(details);
  }

  void getDetails(String href) async {
    Map<String, String> queryParameters = Uri.parse(href).queryParameters;
    String uuid = queryParameters["uuid"]!;
    String uriPath = kDetailsPath + uuid;
    Uri uri = Uri(
      scheme: kDetailsScheme,
      host: kDetailsHost,
      path: uriPath,
    );
    details = await NetworkHelper(uri: uri).getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("关于"),
      ),
      body: const Center(
        child: Text("关于本软件"),
      ),
    );
  }
}
