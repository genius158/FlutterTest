import 'package:flutter/material.dart';
import 'dart:ui' as ui show window;

import 'package:flutter/rendering.dart';

class ViewAdapterWidget extends StatelessWidget {
  Size _screenAdapterSize = Size(360, 640);

  Widget _child;

  ViewAdapterWidget(this._child);

  @override
  Widget build(BuildContext context) {
    return new AdapterRenderObjectWidget(_screenAdapterSize, _child);
  }
}

class AdapterRenderObjectWidget extends SingleChildRenderObjectWidget {
  Size _screenAdapterSize;
  Widget _child;

  AdapterRenderObjectWidget(this._screenAdapterSize, this._child)
      : super(child: _child);

  @override
  SingleChildRenderObjectElement createElement() {
    return super.createElement();
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return new AdapterRenderBox(this._screenAdapterSize);
  }
}

class AdapterRenderBox extends RenderShiftedBox {
  AdapterRenderBox(
    this._screenAdapterSize, {
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

  @override
  void visitChildren(visitor) {
    print("visitChildren      ");
    super.visitChildren(visitor);
  }

  @override
  // TODO: implement constraints
  BoxConstraints get constraints => adapterConstraints();

  final Size _windowSize = ui.window.physicalSize / ui.window.devicePixelRatio;
  Size _screenAdapterSize;
  BoxConstraints _innerConstraints;

  BoxConstraints reset(BoxConstraints constraints) {
    print("reset   " + constraints.toString());

    double widthRatio = _windowSize.width / _screenAdapterSize.width;
    double minWidth = constraints.minWidth * widthRatio;
    minWidth = minWidth > _windowSize.width ? _windowSize.width : minWidth;
    double maxWidth = constraints.maxWidth * widthRatio;
    maxWidth = maxWidth > _windowSize.width ? _windowSize.width : maxWidth;
    double heightRatio = _windowSize.height / _screenAdapterSize.height;
    double minHeight = constraints.minHeight * heightRatio;
    minHeight = minHeight > _windowSize.height ? _windowSize.height : minHeight;
    double maxHeight = constraints.maxHeight * heightRatio;
    maxHeight = maxHeight > _windowSize.height ? _windowSize.height : maxHeight;

    if (_innerConstraints != null &&
        _innerConstraints.minWidth == minWidth &&
        _innerConstraints.maxWidth == maxWidth &&
        _innerConstraints.minHeight == minHeight &&
        _innerConstraints.maxHeight == maxHeight) {
      print("reset2222   " + _innerConstraints.toString());

      return _innerConstraints;
    }

    _innerConstraints = BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight);
    print("reset33333  " + _innerConstraints.toString());

    return _innerConstraints;
  }

  adapterConstraints() {
    return reset(super.constraints);
  }
}
