import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  // Loaded before runApp so persisted state is there on the first frame.
  final prefs = await SharedPreferences.getInstance();
  runApp(App(prefs: prefs));
}
