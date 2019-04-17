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
  RenderObject createRenderObject(BuildContext context) {
    return new AdapterRenderBox();
  }
}

class InnerDelegate extends SingleChildLayoutDelegate {
  @override
  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    return this != oldDelegate;
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return reset(constraints);
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return reset(constraints).smallest;
  }
}

class AdapterRenderBox extends RenderCustomSingleChildLayoutBox {
  AdapterRenderBox() : super(delegate: new InnerDelegate());

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset * getAdapterRatioRatio());
  }
}

final Size _windowSize = ui.window.physicalSize / ui.window.devicePixelRatio;
BoxConstraints _innerConstraints;

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
