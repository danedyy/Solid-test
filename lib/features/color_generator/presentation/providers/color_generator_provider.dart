import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solid_test/core/core.dart';
import 'package:solid_test/features/color_generator/domain/repositories/color_generator_repository.dart';

/// [ColorGeneratorProvider] class that extends ChangeNotifier.
/// It uses provider to manage and provide data related to color generation.
/// The class is designed to work with a ColorGeneratorRepository
/// object that is injected to its constructor
/// [ChangeNotifier]  the class supports change notifications,
/// allowing widgets to listen to changes in data and rebuild accordingly.

class ColorGeneratorProvider extends ChangeNotifier {
  /// [colorGeneratorRepository] It represents an instance of the
  /// [ColorGeneratorRepository] class and is used to manage and handle data
  /// and business logic related to color generation
  /// within the [ColorGeneratorProvider]

  final ColorGeneratorRepository colorGeneratorRepository;

  Color? _color;
  Color? _previousColor;

  /// [color] It provides access to the current color (_color) of the
  ///  color generator. This getter allows external code, such as widgets,
  ///  to retrieve the current color without directly accessing the private
  /// _color instance variable.

  Color? get color => _color;

  /// [previousColor] It provides access to the previous color (_previousColor)
  ///  of the color generator. This getter allows external code,
  /// such as widgets, to retrieve the previous color without directly
  /// accessing the private _previousColor instance variable.

  Color? get previousColor => _previousColor;

  /// Constructor class [ColorGeneratorProvider] The colorGeneratorRepository
  /// parameter is required and represents an instance
  /// of the ColorGeneratorRepository. This repository is used to handle data
  /// and business logic related to color generation.

  ColorGeneratorProvider(this.colorGeneratorRepository);

  /// [generateRandomColor] It generates a random RGB color and sets
  /// it as the current color (_color) in the provider.
  /// It also keeps track of the previous color (_previousColor)before the new
  /// color is generated. After updating the color, it notifies all registered
  /// listeners that the color has changed using notifyListeners()

  void generateRandomColor([Random? random]) {
    random = random ?? Random();
    final int r = random.nextInt(256);
    final int g = random.nextInt(256);
    final int b = random.nextInt(256);

    final newColor = Color.fromRGBO(r, g, b, 1.0);

    _previousColor = _color;
    _color = newColor;

    colorGeneratorRepository.saveColors(
      previousColor: _previousColor,
      color: _color,
    );

    notifyListeners();
  }

  /// [loadColors] is responsible for loading color data using the
  /// colorGeneratorRepository and updating the _color and _previousColor state
  /// variables in the provider based on the loaded data. After updating the
  /// colors, it calls notifyListeners() to inform listeners (usually widgets)
  /// about the changes so that they can rebuild and reflect the updated colors.

  // The [loadColors] method uses the rightOrNull getter from the
  // EitherExtension extension to check if the result res contains a right value
  // (i.e., no failure occurred during loading).
  Future<void> loadColors() async {
    final res = await colorGeneratorRepository.loadColors();
    if (res.rightOrNull != null) {
      _color = res.rightOrNull?.selectedColor;
      _previousColor = res.rightOrNull?.previousColor;
      notifyListeners();
    }
  }
}
