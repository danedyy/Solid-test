import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:solid_test/core/core.dart';
import 'package:solid_test/features/color_generator/model/load_colors_model.dart';

/// [ColorGeneratorRepository] The ColorGeneratorRepository abstract class
/// represents a repository contract for handling color generation and data
/// management related to color data

abstract class ColorGeneratorRepository {
  /// [loadColors] This method is responsible for loading color data from the
  /// data source. It returns a Future with an Either type that can contain
  /// either a Failure if there was an error, or a LoadColorsModel
  /// object if the operation is successful.

  Future<Either<Failure, LoadColorsModel>> loadColors();

  /// [saveColors] This method is responsible for saving color data to the data
  /// source. It returns a Future with an Either type that can contain either a
  /// Failure if there was an error, or void if the operation is successful.
  /// Parameters:
  /// Color previousColor: The previous color before the new color is saved.
  /// Color color: The current color that needs to be saved

  Future<Either<Failure, void>> saveColors({
    required Color? previousColor,
    required Color? color,
  });
}
