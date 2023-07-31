import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solid_test/core/errors/failure.dart';
import 'package:solid_test/features/color_generator/data/data_sources/local_datasource.dart';
import 'package:solid_test/features/color_generator/data/repositories/color_generator_repository_impl.dart';
import 'package:solid_test/features/color_generator/model/load_colors_model.dart';

import 'color_generator_repository_test.mocks.dart';

@GenerateMocks(
  [LocalDatasource],
)
void main() {
  late ColorGeneratorRepositoryImpl repository;
  late MockLocalDatasource mockLocalDatasource;

  setUp(() {
    mockLocalDatasource = MockLocalDatasource();
    repository =
        ColorGeneratorRepositoryImpl(localDatasource: mockLocalDatasource);
  });

  group('loadColors', () {
    test('should return loaded colors from LocalDatasource', () async {
      // Arrange
      final loadedColorsModel = LoadColorsModel(Colors.blue, Colors.green);
      when(mockLocalDatasource.loadColors())
          .thenAnswer((_) async => loadedColorsModel);

      // Act
      final result = await repository.loadColors();

      // Assert
      expect(result, equals(Right(loadedColorsModel)));
      verify(mockLocalDatasource.loadColors());
      verifyNoMoreInteractions(mockLocalDatasource);
    });

    test('should return a Failure when LocalDatasource throws an exception',
        () async {
      // Arrange
      when(mockLocalDatasource.loadColors()).thenThrow(Exception());

      // Act
      final result = await repository.loadColors();

      // Assert
      expect(result, equals(const Left(Failure.unknown())));
      verify(mockLocalDatasource.loadColors());
      verifyNoMoreInteractions(mockLocalDatasource);
    });
  });

  group('saveColors', () {
    test('should save colors to LocalDatasource', () async {
      // Arrange
      const previousColor = Colors.yellow;
      const color = Colors.red;

      // Act
      final result = await repository.saveColors(
        previousColor: previousColor,
        color: color,
      );

      // Assert
      expect(result, equals(const Right(null)));
      verify(
        mockLocalDatasource.saveColor(
          previousColor: previousColor,
          color: color,
        ),
      );
      verifyNoMoreInteractions(mockLocalDatasource);
    });

    test('should return a Failure when LocalDatasource throws an exception',
        () async {
      // Arrange
      const previousColor = Colors.yellow;
      const color = Colors.red;
      when(
        mockLocalDatasource.saveColor(
          previousColor: previousColor,
          color: color,
        ),
      ).thenThrow(Exception());

      // Act
      final result = await repository.saveColors(
        previousColor: previousColor,
        color: color,
      );

      // Assert
      expect(result, equals(const Left(Failure.unknown())));
      verify(
        mockLocalDatasource.saveColor(
          previousColor: previousColor,
          color: color,
        ),
      );
      verifyNoMoreInteractions(mockLocalDatasource);
    });
  });
}
