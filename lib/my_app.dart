import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solid_test/core/core.dart';
import 'package:solid_test/features/color_generator/domain/repositories/color_generator_repository.dart';
import 'package:solid_test/features/color_generator/presentation/pages/color_generator_page.dart';
import 'package:solid_test/features/color_generator/presentation/providers/color_generator_provider.dart';

/// [MyApp] StatelessWidget, which means it doesn't have any internal state and
/// is used to define the root of the widget tree for the application.
/// It represents the overall structure and configuration of the app.
class MyApp extends StatelessWidget {
  /// [MyApp] constructor class. It accepts an optional Key parameter that can
  /// be used to uniquely identify this widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solid Color generator',
      home: ChangeNotifierProvider(
        create: (context) => ColorGeneratorProvider(
          sl<ColorGeneratorRepository>(),
        ),
        child: const ColorGeneratorPage(),
      ),
    );
  }
}
