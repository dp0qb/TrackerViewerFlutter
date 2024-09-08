import 'package:flutter/material.dart';
import 'package:track_viewer/pages/about.dart';
import 'package:track_viewer/pages/home.dart';
import 'package:track_viewer/pages/middle.dart';
import 'package:track_viewer/pages/result.dart';
import 'package:track_viewer/pages/settings.dart';

Map routes = {
  "/": (context) => const HomePage(),
  "/about": (context) => const AboutPage(),
  "/middle": (context, {arguments}) => MiddlePage(arguments: arguments),
  "/result": (context, {arguments}) => ResultPage(arguments: arguments),
  "/settings": (context) => const SettingsPage(),
};

var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];

  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments),
      );
      return route;
    } else {
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context),
      );
      return route;
    }
  }
  return null;
};
