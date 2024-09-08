import 'package:flutter/material.dart';
import 'package:track_viewer/constants.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:track_viewer/services/networking.dart';

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
    print(details);
  }

  String timeParse(int timeStamp) {
    timeStamp *= 1000;
    return DateTime.fromMillisecondsSinceEpoch(timeStamp)
        .toLocal()
        .toString()
        .substring(0, 16);
  }

  void getReviewEvents() async {
    reviewEvents = details["ReviewEvents"];
    nRevisions = details["LatestRevisionNumber"];
    for (var e in reviewEvents) {
      reviewers.add(e["Id"]);
    }
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
    reviewEvents = tempReviewEvents;
    print(reviewEvents);
    print(timeParse(reviewEvents[0][1]["Date"]));
    // print(reviewers);
    print(details);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("解析结果"),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
                // title: Text(details["ManuscriptTitle"]),
                ),
          ],
        ),
        // child: const Text("解析结果页面"),
      ),
    );
  }
}
