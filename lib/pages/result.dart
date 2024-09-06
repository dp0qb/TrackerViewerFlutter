import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:track_viewer/constants.dart';

class ResultPage extends StatefulWidget {
  final Map arguments;
  const ResultPage({super.key, required this.arguments});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrack(widget.arguments["href"]);
    // print(widget.arguments);
  }

  void getTrack(String href) async {
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
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
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
