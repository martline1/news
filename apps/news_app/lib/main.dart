import 'package:flutter/material.dart';

import 'package:news_app/app.dart';
import 'package:news_lib/di/app_dependencies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AppDependencies.init();

  runApp(const App());
}
