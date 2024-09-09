import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("设置"),
      ),
      body: const Center(
        child: Text(
          "作者很懒，还没写相应功能。",
        ),
        // child: ListView(
        //   children: const [
        //     ListTile(
        //       title: Text("作者很懒，还没写相应功能。"),
        //     ),
        //     ListTile(),
        //     ListTile(),
        //   ],
        // ),
      ),
    );
  }
}
