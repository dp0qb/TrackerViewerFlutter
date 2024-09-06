import 'package:flutter/material.dart';
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
            const Text("主页"),
            const SizedBox(
              height: 45,
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: Center(
                child: TextField(
                  controller: textController,
                  minLines: 1, //必须填1，输入内容才可居中，其他默认是左上对齐
                  maxLines: 10, //最多行数，大于1即可
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
                // print(widget.te);
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
        child: ListView(
          children: const [
            ListTile(
              title: Text("设置"),
            ),
            ListTile(
              title: Text("关于"),
            ),
          ],
        ),
      ),
    );
  }
}
