import 'package:dartz/dartz.dart';

/// [EitherExtension] The EitherExtension extension provides two getter methods,
///  leftOrNull and rightOrNull, that allow convenient access to the left
/// and right values of an Either<L, R> object. This extension is used to
/// simplify working with Either types and make it easier to handle both left
/// (failure) and right (success) scenarios.

extension EitherExtension<L, R> on Either<L, R> {
  /// [leftOrNull] The leftOrNull getter returns a nullable L value,
  /// which represents the left value of the Either.
  /// If the Either contains a left value (Left<L>),
  /// the value is returned; otherwise, null is returned.

  L? get leftOrNull {
    return fold((l) => l, (r) => null);
  }

  /// The rightOrNull getter returns a nullable R value, which represents
  /// the right value of the Either. If the Either containsa right value
  ///  (Right<R>), the value is returned; otherwise, null is returned.

  R? get rightOrNull {
    return fold((l) => null, (r) => r);
  }
}
