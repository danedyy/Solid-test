import 'dart:ui';

/// The [LoadColorsModel] class represents a model that holds data related to
/// loaded colors. It is used to store information about the previous color and
/// the currently selected color.
class LoadColorsModel {
  /// The [previousColor] parameter represents the previous color before the new
  ///  color is selected. It is of type Color

  final Color previousColor;

  /// The [selectedColor] parameter represents the currently selected color.
  /// It is of type Color
  final Color selectedColor;

  /// Color [previousColor]: A read-only property that holds the previous color.
  /// This property cannot be modified after the object is constructed.
  /// Color [selectedColor]: A read-only property that holds the currently
  /// selected color. This property cannot be modified after the object is
  /// constructed.

  LoadColorsModel(this.previousColor, this.selectedColor);
}
