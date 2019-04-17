import 'package:flutter_app/view_adapter_config.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';

class AdapterContainer extends Container {
  AdapterContainer({
    Key key,
    AlignmentGeometry alignment,
    EdgeInsetsGeometry padding,
    Color color,
    Decoration decoration,
    Decoration foregroundDecoration,
    double width,
    double height,
    BoxConstraints constraints,
    EdgeInsetsGeometry margin,
    Matrix4 transform,
    Widget child,
  }) : super(
          key: key,
          alignment: alignment,
          padding: padding,
          color: color,
          decoration: decoration,
          foregroundDecoration: foregroundDecoration,
          width: width,
          height: height,
          constraints: constraints,
          margin: margin,
          transform: transform,
          child: child,
        );

  EdgeInsetsGeometry get _paddingIncludingDecoration {
    if (decoration == null || decoration.padding == null) return padding;
    final EdgeInsets decorationPadding = decoration.padding;
    if (padding == null) return decorationPadding;
    return padding.add(decorationPadding);
  }

  @override
  Widget build(BuildContext context) {
    Widget current = child;

    if (child == null && (constraints == null || !constraints.isTight)) {
      current = LimitedBox(
          maxWidth: 0.0,
          maxHeight: 0.0,
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
          ));
    }
    double ratio = getAdapterRatioRatio();

    if (alignment != null)
      current = Align(alignment: alignment, child: current);

    final EdgeInsets effectivePadding = _paddingIncludingDecoration;
    if (effectivePadding != null)
      current = Padding(padding: effectivePadding * ratio, child: current);

    if (decoration != null)
      current = DecoratedBox(decoration: decoration, child: current);

    if (foregroundDecoration != null) {
      current = DecoratedBox(
          decoration: foregroundDecoration,
          position: DecorationPosition.foreground,
          child: current);
    }

    if (constraints != null)
      current =
          ConstrainedBox(constraints: constraints * ratio, child: current);

    if (margin != null)
      current = Padding(padding: margin * ratio, child: current);

    if (transform != null)
      current = Transform(transform: transform, child: current);

    return current;
  }
}
