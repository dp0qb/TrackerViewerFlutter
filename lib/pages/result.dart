import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:track_viewer/constants.dart';
import 'package:track_viewer/widgets/info_card.dart';
import 'package:track_viewer/services/networking.dart';

class ResultPage extends StatefulWidget {
  final Map arguments;
  const ResultPage({super.key, required this.arguments});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Map<String, dynamic> details = {};
  // String filePath = "assets/temp_demo_json_files/data.json";

  Future<void> autoLoadData() async {
    // if (widget.arguments["href"] == "") {
    //   await loadDemoJsonData(filePath);
    // } else {
    //   await getDetails(widget.arguments["href"]);
    // }
    await getDetails(widget.arguments["href"]);
  }

  Future<void> loadDemoJsonData(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    details = jsonDecode(jsonString);
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
                // return Text("Error: ${snapshot.error}");
                return const Text("请求失败，请检查设备网络及Track链接是否有效。");
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
  Set<int> reviewerIds = {};
  Map<int, String> reviewers = {};
  List<dynamic> reviewEvents = [];

  String timeParse(int timeStamp) {
    timeStamp *= 1000;
    return DateTime.fromMillisecondsSinceEpoch(timeStamp)
        .toLocal()
        .toString()
        .substring(0, 16);
  }

  void getReviewEvents() {
    int reviewerCount = 0;
    Set<int> revisions = {};
    reviewEvents = widget.details["ReviewEvents"];
    reviewEvents.sort((a, b) => a["Date"].compareTo(b["Date"]));
    for (var e in reviewEvents) {
      reviewerIds.add(e["Id"]);
      revisions.add(e["Revision"]);
    }
    for (var id in reviewerIds) {
      reviewers[id] = "Reviewer ${++reviewerCount}";
    }
    nRevisions = revisions.length;
    List<dynamic> tempReviewEvents = [];
    for (int i = 0; i < nRevisions; i++) {
      List<dynamic> oneRoundReviewEvents = [];
      for (var e in reviewEvents) {
        if (e["Revision"] == i) {
          oneRoundReviewEvents.add(e);
        }
      }
      oneRoundReviewEvents.sort((a, b) => a["Date"].compareTo(b["Date"]));
      tempReviewEvents.add(oneRoundReviewEvents);
    }
    reviewEvents = tempReviewEvents;
  }

  List<Widget> getListTiles() {
    String manuscriptTitle = widget.details["ManuscriptTitle"];
    String firstAuthor = widget.details["FirstAuthor"];
    String correspondingAuthor = widget.details["CorrespondingAuthor"];
    String submissionDate = timeParse(widget.details["SubmissionDate"]);
    List<Widget> listTitles = [
      IntroCard(
          manuscriptTitle: manuscriptTitle,
          firstAuthor: firstAuthor,
          correspondingAuthor: correspondingAuthor,
          submissionDate: submissionDate),
    ];
    getReviewEvents();
    for (List<dynamic> reviewEventsPerRound in reviewEvents) {
      for (dynamic reviewEvent in reviewEventsPerRound) {
        String? timeStr = timeParse(reviewEvent["Date"]);
        String? event = kEventsMap[reviewEvent["Event"]];
        String? reviewer = reviewers[reviewEvent["Id"]];
        listTitles.add(
          ReviewEventCard(
            reviewer: reviewer,
            event: event,
            time: timeStr,
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
