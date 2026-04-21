import 'package:flutter/widgets.dart';

extension PaddingExtension on Widget {
  /// Padding all sides
  Widget padAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Symmetric padding
  Widget padSym({double horizontal = 0, double vertical = 0}) => Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
    child: this,
  );

  /// Only padding
  Widget padOnly({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
    ),
    child: this,
  );
}
