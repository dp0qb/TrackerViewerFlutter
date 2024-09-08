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
  String filePath = "assets/temp_demo_json_files/data.json";

  Future<void> autoLoadData() async {
    if (widget.arguments["href"] == "") {
      await loadDemoJsonData(filePath);
    } else {
      await getDetails(widget.arguments["href"]);
    }
  }

  Future<void> loadDemoJsonData(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    await Future.delayed(const Duration(milliseconds: 500));
    details = jsonDecode(jsonString);
    // print(details);
  }

  Future<void> getDetails(String href) async {
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
        title: const Text("审稿进度"),
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: autoLoadData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text("Error: ${snapshot.error}");
              } else {
                ResultListView resultListView =
                    ResultListView(details: details);
                // 请求成功，显示数据
                return resultListView;
              }
            } else {
              // 请求未结束，显示loading
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class ResultListView extends StatefulWidget {
  final Map<String, dynamic> details;
  const ResultListView({super.key, required this.details});

  @override
  State<ResultListView> createState() => _ResultListViewState();
}

class _ResultListViewState extends State<ResultListView> {
  int nRevisions = 0;
  Set<int> reviewers = {};
  List<dynamic> reviewEvents = [];

  String timeParse(int timeStamp) {
    timeStamp *= 1000;
    return DateTime.fromMillisecondsSinceEpoch(timeStamp)
        .toLocal()
        .toString()
        .substring(0, 16);
  }

  void getReviewEvents() {
    reviewEvents = widget.details["ReviewEvents"];
    nRevisions = widget.details["LatestRevisionNumber"];
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
    print(widget.details);
  }

  List<Widget> getListTiles() {
    List<Widget> listTitles = [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.lightGreen.shade100,
        ),
        child: ListTile(
          title: Text(
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
            widget.details["ManuscriptTitle"],
          ),
          subtitle: Wrap(
            spacing: 15,
            children: [
              Text(
                style: const TextStyle(
                  fontSize: 12,
                ),
                "First Author: ${widget.details["FirstAuthor"]}",
              ),
              Text(
                style: const TextStyle(
                  fontSize: 12,
                ),
                "Corresponding Author: ${widget.details["CorrespondingAuthor"]}",
              ),
            ],
          ),
        ),
      ),
    ];
    getReviewEvents();
    for (List<dynamic> reviewEventsPerRound in reviewEvents) {
      for (dynamic reviewEvent in reviewEventsPerRound) {
        String timeStr = timeParse(reviewEvent["Date"]);
        listTitles.add(
          ListTile(
            title: Wrap(
              spacing: 15,
              children: [
                Text(timeStr),
                Text(
                  "${reviewEvent["Id"]}",
                ),
                Text(
                  "${reviewEvent["Event"]}",
                )
              ],
            ),
          ),
        );
      }
    }

    return listTitles;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: getListTiles(),
      ),
    );
  }
}
