import 'package:flutter/material.dart';
import 'package:track_viewer/widgets/expanded_button.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search,
                size: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
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
              const SizedBox(
                height: 30,
              ),
              ExpandedButton(
                child: const Text("查询"),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "/result",
                    arguments: {"href": textController.text},
                  );
                },
                // icon: Icons.arrow_forward_ios,
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              2,
            ),
          ),
        ),
        width: 220,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 45,
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                ),
                title: const Text("设置"),
                onTap: () => {
                  Navigator.pushNamed(
                    context,
                    "/settings",
                  )
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.info_outline,
                ),
                title: const Text("关于"),
                onTap: () => {
                  Navigator.pushNamed(
                    context,
                    "/about",
                  ),
                },
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
