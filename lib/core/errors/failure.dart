import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solid_test/core/errors/convert_failure_to_string.dart';

part 'failure.freezed.dart';

/// A failure is an interface that is used to represent a
///  failure in the domain layer.
@freezed
class Failure with _$Failure {
  /// [ Failure.noInternet] is a failure that is used to represent failure/error
  ///  from no internet
  const factory Failure.noInternet() = _$NoInternetFailure;

  /// [ Failure.serverError] is a failure that is used to represent
  /// failure/error from server
  const factory Failure.serverError(
    String message,
  ) = _$ServerFailure;

  /// [Failure.unknown()] is a failure that is used to represent failure/error
  /// from unknown source
  const factory Failure.unknown() = _$UnknownFailure;
}

///The [FailureX] extension provides a single method toMessage() that allows
///converting a Failure object to a string representation. The extension is used
/// to handle error messages when working with Failure objects.
extension FailureX on Failure {
  /// [toMessage] converts a failure to a string
  String toMessage() {
    return ConvertFailureToString()(this);
  }
}
