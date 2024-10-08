import 'package:flutter/material.dart';
import 'routers/routers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        fontFamily: "NotoSansSC",
        useMaterial3: true,
      ),
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }
}
