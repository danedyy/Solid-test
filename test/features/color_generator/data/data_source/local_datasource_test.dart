import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solid_test/features/color_generator/data/data_sources/local_datasource.dart';
import 'package:solid_test/features/color_generator/model/load_colors_model.dart';

import 'local_datasource_test.mocks.dart';

void main() {
  late LocalDatasourceImpl localDatasourceImpl;
  late SharedPreferences sharedPreferences;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDatasourceImpl = LocalDatasourceImpl(
      sharedPreferences: sharedPreferences,
    );
  });

  group('loadColors', () {
    test('should return default colors if SharedPreferences data is null',
        () async {
      // Arrange
      when(sharedPreferences.getString(_selectedColorKey)).thenReturn(null);
      when(sharedPreferences.getString(_previousColorKey)).thenReturn(null);

      // Act
      final colors = await localDatasourceImpl.loadColors();
      // Assert
      expect(colors, equalsCustom(LoadColorsModel(Colors.black, Colors.white)));
    });

    test('should return colors from SharedPreferences data', () async {
      // Arrange
      final selectedColorHex =
          Colors.red.value.toRadixString(16); // Red color in hexadecimal
      final previousColorHex =
          Colors.green.value.toRadixString(16); // Green color in hexadecimal

      when(sharedPreferences.getString(_selectedColorKey))
          .thenReturn(selectedColorHex);
      when(sharedPreferences.getString(_previousColorKey))
          .thenReturn(previousColorHex);

      // Act
      final colors = await localDatasourceImpl.loadColors();

      // Assert
      expect(
        MaterialColor(colors.selectedColor.value, const {}),
        MaterialColor(Colors.red.value, const {}),
      );
      expect(
        MaterialColor(colors.previousColor.value, const {}),
        MaterialColor(Colors.green.value, const {}),
      );
    });

    test('should rethrow exception when an error occurs', () async {
      // Arrange
      when(sharedPreferences.getString(_selectedColorKey))
          .thenThrow(Exception('Test Error'));
      when(sharedPreferences.getString(_previousColorKey))
          .thenThrow(Exception('Test Error'));

      // Act and Assert
      expect(
        localDatasourceImpl.loadColors(),
        throwsA(isInstanceOf<Exception>()),
      );
    });
  });

  group('saveColor', () {
    test('should save colors to SharedPreferences', () async {
      // Arrange
      const selectedColor = Colors.blue;
      const previousColor = Colors.yellow;
      final selectedColorHex =
          selectedColor.value.toRadixString(16); // Blue color in hexadecimal
      final previousColorHex =
          previousColor.value.toRadixString(16); // Yellow color in hexadecimal
      // Act
      await localDatasourceImpl.saveColor(
        color: selectedColor,
        previousColor: previousColor,
      );
      // Assert
      verify(
        sharedPreferences.setString(
          _selectedColorKey,
          selectedColorHex,
        ),
      );
      verify(
        sharedPreferences.setString(
          _previousColorKey,
          previousColorHex,
        ),
      );
    });

    test('should do nothing if either color is null', () async {
      // Arrange
      const selectedColor = Colors.blue;

      // Act
      await localDatasourceImpl.saveColor(
        color: selectedColor,
        previousColor: null,
      );

      // Assert
      verifyNever(sharedPreferences.setString('any', 'any'));
    });
  });
}

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<SharedPreferences>(onMissingStub: OnMissingStub.returnDefault)
  ],
)
const String _previousColorKey = 'previousColor';

const String _selectedColorKey = 'selectedColor';

Matcher equalsCustom(LoadColorsModel expected) => _EqualsCustom(expected);

class _EqualsCustom extends Matcher {
  final LoadColorsModel _expected;

  _EqualsCustom(this._expected);

  @override
  Description describe(Description description) {
    return description.add('Expected: $_expected');
  }

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! LoadColorsModel) return false;

    final LoadColorsModel actual = item;

    return actual.previousColor == _expected.previousColor &&
        actual.selectedColor == _expected.selectedColor;
  }
}
