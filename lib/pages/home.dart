import 'package:flutter/material.dart';
import 'package:track_viewer/pages/about.dart';
import 'package:track_viewer/pages/settings.dart';
import './result.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  static const textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide(
      width: 1,
      color: Colors.lightBlueAccent,
    ),
  );

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Viewer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              size: 100,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: Center(
                child: TextField(
                  controller: textController,
                  minLines: 1,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    border: textFieldBorder,
                    focusedBorder: textFieldBorder,
                    errorBorder: textFieldBorder,
                    disabledBorder: textFieldBorder,
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ResultPage(
                        arguments: {"href": textController.text},
                      );
                    },
                  ),
                );
              },
              child: const Text("解析 ->"),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        width: 220,
        // shape: Border.all(),
        child: ListView(
          children: [
            const SizedBox(
              height: 45,
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.settings,
                ),
              ),
              title: const Text("设置"),
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const SettingsPage();
                    },
                  ),
                ),
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.info_outline,
                ),
              ),
              title: const Text("关于"),
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const AboutPage();
                    },
                  ),
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
