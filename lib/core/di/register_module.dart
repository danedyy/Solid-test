import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [RegisterModule] is used to register modules(for third party dependencies)
@module
abstract class RegisterModule {
  @preResolve

  /// [SharedPreferences] resolves [SharedPreferences] to be injected a
  /// s a dependency
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
}
