import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:track_viewer/constants.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ResultPage extends StatefulWidget {
  final Map arguments;
  const ResultPage({super.key, required this.arguments});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Map<String, dynamic> details = {};
  int nRevisions = 0;
  Set<int> reviewers = {};
  List<dynamic> reviewEvents = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.arguments["href"] == "") {
      String filePath = "assets/temp_demo_json_files/data.json";
      loadDemoJsonData(filePath);
    } else {
      getDetails(widget.arguments["href"]);
    }
  }

  void loadDemoJsonData(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    details = jsonDecode(jsonString);
    getReviewEvents();
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
    Response response = await get(uri);
    if (response.statusCode == 200) {
      details = json.decode(response.body);
    } else {
      print(response.statusCode);
    }
    print(details);
    getReviewEvents();
  }

  void getReviewEvents() async {
    reviewEvents = details["ReviewEvents"];
    nRevisions = details["LatestRevisionNumber"];
    for (var e in reviewEvents) {
      reviewers.add(e["Id"]);
    }
    // reviewEvents.map((e) => reviewers.add(e["Id"]));
    List<dynamic> tempReviewEvents = [];
    for (int i = 0; i < nRevisions; i++) {
      List<dynamic> oneRoundReviewEvents = [];
      for (var e in reviewEvents) {
        if (e["Revision"] == i) {
          oneRoundReviewEvents.add(e);
        }
      }
      tempReviewEvents.add(oneRoundReviewEvents);
    }
    print(tempReviewEvents);
    print(reviewers);
    print(details);
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
