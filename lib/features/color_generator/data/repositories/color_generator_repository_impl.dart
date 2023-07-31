import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:solid_test/core/errors/failure.dart';
import 'package:solid_test/features/color_generator/data/data_sources/local_datasource.dart';
import 'package:solid_test/features/color_generator/domain/repositories/color_generator_repository.dart';
import 'package:solid_test/features/color_generator/model/load_colors_model.dart';

@LazySingleton(as: ColorGeneratorRepository)

/// [ColorGeneratorRepositoryImpl] class is a concrete implementation of the
/// ColorGeneratorRepository interface. It serves as a repository that
/// handles color generation and data management related to color data

class ColorGeneratorRepositoryImpl implements ColorGeneratorRepository {
  /// The [localDatasource] parameter is required and represents a concrete
  /// implementation of the LocalDatasource interface.
  /// It provides the ability to interact with a local data source to
  /// load and save color data

  final LocalDatasource localDatasource;

  /// The [ColorGeneratorRepositoryImpl] class implements the
  /// ColorGeneratorRepository interface, which defines methods
  ///  related to color generation.

  ColorGeneratorRepositoryImpl({
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, LoadColorsModel>> loadColors() async {
    try {
      final loadedColors = await localDatasource.loadColors();

      return Right(loadedColors);
    } catch (e) {
      return const Left(Failure.unknown());
    }
  }

  @override
  Future<Either<Failure, void>> saveColors({
    required Color? previousColor,
    required Color? color,
  }) async {
    try {
      await localDatasource.saveColor(
        previousColor: previousColor,
        color: color,
      );

      return const Right(null);
    } catch (e) {
      return const Left(Failure.unknown());
    }
  }
}
