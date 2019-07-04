// custom layout test 自定义container

import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

export 'dart:ui' show AppLifecycleState, Locale;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: CustomLayout(getChildren()),
    );
  }

  List<Widget> getChildren() {
    return [
      Text("11111111111111111111111"),
      Container(
        child: Text(
            "222222222222222222222222222222222222222222222222222222222222222222222222222222"),
        height: 200,
        alignment: Alignment.center,
      ),
      Text("333333333333333333333")
    ];
  }
}

class CustomLayout extends MultiChildRenderObjectWidget {
  Color color;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomLayoutRender(color: color);
  }

  CustomLayout(List<Widget> children, {this.color}) : super(children: children);
}

class CustomLayoutRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CustomParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CustomParentData> {
  var innerPaint = new Paint();

  CustomLayoutRender({List<RenderBox> children, Color color}) {
    addAll(children);
    innerPaint.color = color ?? Colors.transparent;
  }

  @override
  void setupParentData(RenderBox child) {
    final ParentData childParentData = child.parentData;
    if (childParentData is! CustomParentData) {
      child.parentData = CustomParentData();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawRect(
        Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height),
        innerPaint);
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(HitTestResult result, {Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void performLayout() {
    if (childCount == 0) {
      return;
    }

    var child = firstChild;

    var layoutHeight = 0.0;

    var width = constraints.maxWidth / childCount;
    var cc = constraints.tighten(width: width);
    var index = 0;
    while (child != null) {
      final CustomParentData childParentData = child.parentData;
      child.layout(cc, parentUsesSize: true);
      layoutHeight = math.max(layoutHeight, child.size.height);

      childParentData.offset =
          Offset(index * width + (width - child.size.width) / 2, 0);
      ++index;

      child = childParentData.nextSibling;
    }

    size = constraints
        .tighten(
          height: layoutHeight,
        )
        .biggest;
  }
}

class CustomParentData extends ContainerBoxParentData<RenderBox> {}
