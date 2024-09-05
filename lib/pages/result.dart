import 'package:flutter/material.dart';

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
    print(widget.arguments);
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
