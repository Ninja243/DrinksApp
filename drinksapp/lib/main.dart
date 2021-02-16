import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

  // Called when app is terminated [android only]
  // BackgroundFetch.registerHeadlessTask(callback)
}
