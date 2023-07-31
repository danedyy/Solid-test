import 'package:flutter/material.dart';
import 'package:solid_test/core/core.dart';
import 'package:solid_test/my_app.dart';

/// [configureDependencies] configures any necessary dependencies, and starts
/// the execution of the app by running the MyApp widget.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const MyApp());
}
