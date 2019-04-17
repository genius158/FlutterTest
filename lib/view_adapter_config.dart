import 'package:flutter/rendering.dart';
import 'dart:ui' as ui show window;

const double SCREEN_WIDTH = 400;

double getAdapterRatio() {
  return ui.window.physicalSize.width / SCREEN_WIDTH;
}

double getAdapterRatioRatio() {
  return getAdapterRatio() / ui.window.devicePixelRatio;
}

Size getScreenAdapterSize() {
  return Size(SCREEN_WIDTH, ui.window.physicalSize.height / getAdapterRatio());
}
