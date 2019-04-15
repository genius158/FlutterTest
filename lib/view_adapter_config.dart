import 'package:flutter/rendering.dart';
import 'dart:ui' as ui show window;

const Size SCREEN_ADAPTER_SIZE = Size(360, 640);

double getAdapterRatio() {
  return ui.window.physicalSize.height / SCREEN_ADAPTER_SIZE.height;
}

double getAdapterRatioRatio() {
  return (ui.window.physicalSize.height / SCREEN_ADAPTER_SIZE.height) /
      ui.window.devicePixelRatio;
}
