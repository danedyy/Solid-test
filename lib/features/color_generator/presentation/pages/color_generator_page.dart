import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solid_test/features/color_generator/presentation/providers/color_generator_provider.dart';

/// [ColorGeneratorPage]  It represents a page/screen where color generation and
/// display-related functionalities are implemented. As a StatefulWidget,
/// the ColorGeneratorPage can maintain its state and update its user interface
/// based on changes.
class ColorGeneratorPage extends StatefulWidget {
  /// Key? key: An optional Key that represents a unique identifier for the
  /// [ColorGeneratorPage]. It is used by Flutter's widget tree to efficiently
  /// update the user interface.

  const ColorGeneratorPage({super.key});

  @override
  State<ColorGeneratorPage> createState() => _ColorGeneratorPageState();
}

class _ColorGeneratorPageState extends State<ColorGeneratorPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ColorGeneratorProvider>(context, listen: false).loadColors();
  }

  final double _fontSize = 20;
  @override
  Widget build(BuildContext context) {
    final colorGenProv = Provider.of<ColorGeneratorProvider>(context);

    return Scaffold(
      backgroundColor: colorGenProv.color,
      body: InkWell(
        onTap: () {
          colorGenProv.generateRandomColor();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          alignment: Alignment.center,
          color: colorGenProv.color,
          child: Text(
            'Hello there!',
            style: TextStyle(
              fontSize: _fontSize,
              color: colorGenProv.previousColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
