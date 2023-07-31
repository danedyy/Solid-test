import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solid_test/features/color_generator/model/load_colors_model.dart';

const String _previousColorKey = 'previousColor';
const String _selectedColorKey = 'selectedColor';

/// [LocalDatasource] abstract class represents a local data source contract
/// for handling color data
abstract class LocalDatasource {
  /// [loadColors] This method is responsible for loading color data from the
  /// local data source and returning a LoadColorsModel object.
  /// Return Type:
  /// Future<LoadColorsModel>: A Future that completes with a
  /// LoadColorsModel object, which holds the loaded color data.

  Future<LoadColorsModel> loadColors();

  /// [saveColor] This method is responsible for saving color data to the local
  ///  data source.
  /// Parameters:
  /// Color previousColor: The previous color before the new color is saved.
  /// Color color: The current color that needs to be saved.
  /// Return Type:
  /// Future<void>: A Future that completes when the save operation is finished.

  Future<void> saveColor({
    required Color? previousColor,
    required Color? color,
  });
}

@LazySingleton(as: LocalDatasource)

/// [LocalDatasourceImpl] implementaion class for LocalDatasource
class LocalDatasourceImpl implements LocalDatasource {
  /// [SharedPreferences] is used to store data in the device
  final SharedPreferences sharedPreferences;

  /// [sharedPreferences] requires [SharedPreferences] to be injected
  LocalDatasourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<LoadColorsModel> loadColors() async {
    try {
      // Retrieve the colors string from SharedPreferences
      final String? selectedColorString =
          sharedPreferences.getString(_selectedColorKey);
      final String? previousColorString =
          sharedPreferences.getString(_previousColorKey);

      // If the colorString is null, return a default color
      if (selectedColorString == null || previousColorString == null) {
        return LoadColorsModel(
          Colors.black,
          Colors.white,
        ); // You can choose any default color here
      }

      // Convert the hexadecimal color string back to a Color object
      final Color selectedColor =
          Color(int.parse(selectedColorString, radix: 16));
      final Color previousColor =
          Color(int.parse(previousColorString, radix: 16));

      return LoadColorsModel(
        previousColor,
        selectedColor,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveColor({
    required Color? previousColor,
    required Color? color,
  }) async {
    // Convert the colors to a hexadecimal string representation
    final String? selectedColorString = color?.value.toRadixString(16);
    final String? previousColorString = previousColor?.value.toRadixString(16);

    if (selectedColorString == null || previousColorString == null) {
      return;
    }

    // Save the colors string in SharedPreferences
    await sharedPreferences.setString(_selectedColorKey, selectedColorString);
    await sharedPreferences.setString(_previousColorKey, previousColorString);
  }
}
