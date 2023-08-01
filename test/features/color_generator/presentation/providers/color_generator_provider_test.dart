import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solid_test/core/errors/failure.dart';
import 'package:solid_test/features/color_generator/domain/repositories/color_generator_repository.dart';
import 'package:solid_test/features/color_generator/model/load_colors_model.dart';
import 'package:solid_test/features/color_generator/presentation/providers/color_generator_provider.dart';

import 'color_generator_provider_test.mocks.dart';

@GenerateMocks(
  [ColorGeneratorRepository, Random],
)
void main() {
  late ColorGeneratorProvider colorGeneratorProvider;
  late MockColorGeneratorRepository mockRepository;

  setUp(() {
    mockRepository = MockColorGeneratorRepository();
    colorGeneratorProvider = ColorGeneratorProvider(mockRepository);
  });

  group('loadColors', () {
    test('should load colors from repository and notify listeners', () async {
      // Arrange
      const selectedColor = Colors.blue;
      const previousColor = Colors.green;
      final loadColorsModel = LoadColorsModel(previousColor, selectedColor);
      when(mockRepository.loadColors())
          .thenAnswer((_) => Future.value(Right(loadColorsModel)));

      // Act
      await colorGeneratorProvider.loadColors();

      // Assert
      expect(colorGeneratorProvider.color, selectedColor);
      expect(colorGeneratorProvider.previousColor, previousColor);
      verify(mockRepository.loadColors());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should do nothing if loading fails', () async {
      // Arrange
      when(mockRepository.loadColors())
          .thenAnswer((_) => Future.value(const Left(Failure.unknown())));

      // Act
      await colorGeneratorProvider.loadColors();

      // Assert
      expect(colorGeneratorProvider.color, isNull);
      expect(colorGeneratorProvider.previousColor, isNull);
      verify(mockRepository.loadColors());
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
