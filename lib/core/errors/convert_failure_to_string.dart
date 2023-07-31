import 'package:solid_test/core/errors/failure.dart';

///[ConvertFailureToString] is a helper class that
/// converts a failure to a string
class ConvertFailureToString {
  /// [call] converts a failure to a string
  String call(Failure failure) {
    return failure.map(
      serverError: (failure) => failure.message,
      noInternet: (failure) =>
          '''Please check your internet connection and try again''',
      unknown: (failure) => 'Unknown error:',
    );
  }
}
