import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solid_test/core/core.dart';

/// This is the root of the dependency injection tree.
final GetIt sl = GetIt.instance;

@injectableInit

/// this is the method to initialize the dependency injection tree.
Future<void> configureDependencies() async => sl.init();
