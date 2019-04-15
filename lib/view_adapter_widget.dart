import 'package:flutter_app/view_adapter_config.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'dart:ui' as ui show window;

///
/// use like
/// Container(
///          height: 100,
///          child: ViewAdapterWidget(
///            Text("test"),
///          ),
///        )
///
class ViewAdapterWidget extends StatelessWidget {
  Widget _child;

  ViewAdapterWidget(this._child);

  @override
  Widget build(BuildContext context) {
    return new AdapterRenderObjectWidget(_child);
  }
}

class AdapterRenderObjectWidget extends SingleChildRenderObjectWidget {
  Widget _child;

  AdapterRenderObjectWidget(this._child) : super(child: _child);

  @override
  SingleChildRenderObjectElement createElement() {
    return super.createElement();
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return new AdapterRenderBox();
  }
}

class AdapterRenderBox extends RenderShiftedBox {
  final Size _windowSize = ui.window.physicalSize / ui.window.devicePixelRatio;
  BoxConstraints _innerConstraints;

  AdapterRenderBox({
    RenderBox child,
  }) : super(child);

  Size _getSize(BoxConstraints constraints) {
    return Size(constraints.constrainWidth(), constraints.constrainHeight());
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final double width =
        _getSize(BoxConstraints.tightForFinite(height: height)).width;
    if (width.isFinite) return width;
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double width =
        _getSize(BoxConstraints.tightForFinite(height: height)).width;
    if (width.isFinite) return width;
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final double height =
        _getSize(BoxConstraints.tightForFinite(width: width)).height;
    if (height.isFinite) return height;
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final double height =
        _getSize(BoxConstraints.tightForFinite(width: width)).height;
    if (height.isFinite) return height;
    return 0.0;
  }

  void performLayout() {
    BoxConstraints tempConstraints = constraints;
    size = _getSize(tempConstraints);
    if (child != null) {
      final BoxConstraints childConstraints = tempConstraints;
      assert(childConstraints.debugAssertIsValid(isAppliedConstraint: true));
      child.layout(childConstraints, parentUsesSize: !childConstraints.isTight);
    }
  }

  BoxConstraints reset(BoxConstraints constraints) {
    double ratio = getAdapterRatioRatio();
    double minWidth = constraints.minWidth * ratio;
    minWidth = minWidth > _windowSize.width ? _windowSize.width : minWidth;
    double maxWidth = constraints.maxWidth * ratio;
    maxWidth = maxWidth > _windowSize.width ? _windowSize.width : maxWidth;
    double minHeight = constraints.minHeight * ratio;
    minHeight = minHeight > _windowSize.height ? _windowSize.height : minHeight;
    double maxHeight = constraints.maxHeight * ratio;
    maxHeight = maxHeight > _windowSize.height ? _windowSize.height : maxHeight;

    if (_innerConstraints != null &&
        _innerConstraints.minWidth == minWidth &&
        _innerConstraints.maxWidth == maxWidth &&
        _innerConstraints.minHeight == minHeight &&
        _innerConstraints.maxHeight == maxHeight) {
      return _innerConstraints;
    }

    _innerConstraints = BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight);
    return _innerConstraints;
  }

  @override
  BoxConstraints get constraints => adapterConstraints();

  adapterConstraints() {
    return reset(super.constraints);
  }
}
