// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;
import 'package:solid_test/core/di/register_module.dart' as _i7;
import 'package:solid_test/features/color_generator/data/data_sources/local_datasource.dart'
    as _i4;
import 'package:solid_test/features/color_generator/data/repositories/color_generator_repository_impl.dart'
    as _i6;
import 'package:solid_test/features/color_generator/domain/repositories/color_generator_repository.dart'
    as _i5;

class _$RegisterModule extends _i7.RegisterModule {}

/// initializes the registration of main-scope dependencies inside of GetIt

extension Sl on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i4.LocalDatasource>(
      () => _i4.LocalDatasourceImpl(
        sharedPreferences: gh<_i3.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i5.ColorGeneratorRepository>(
      () => _i6.ColorGeneratorRepositoryImpl(
        localDatasource: gh<_i4.LocalDatasource>(),
      ),
    );

    return this;
  }
}
