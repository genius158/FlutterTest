import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:developer' as developer;
import 'dart:ui' show AppLifecycleState, Locale, AccessibilityFeatures;
import 'dart:ui' as ui show window;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

export 'dart:ui' show AppLifecycleState, Locale;

void main() => InnerWidgetsFlutterBinding.ensureInitialized()
  ..attachRootWidget(new MyApp())
  ..scheduleWarmUpFrame();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
          Test(),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> getList() {
    return [
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
      Test(),
    ];
  }
}

class Test extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestState();
  }
}

class TestState extends State<Test> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ScrollPosition position = Scrollable.of(context)?.position;
    position?.isScrollingNotifier?.addListener(() {
      print("didChangeDependencies1111" +
          position?.isScrollingNotifier?.value.toString() +
          "  " +
          position?.pixels.toString());
    });
    position?.addListener(() {
      print("didChangeDependencies2222" +
          position?.isScrollingNotifier?.value.toString() +
          "  " +
          position?.pixels.toString());
    });
  }

  Map<Type, GestureRecognizerFactory> _gestureRecognizers =
      const <Type, GestureRecognizerFactory>{};

  @override
  Widget build(BuildContext context) {
    _gestureRecognizers = <Type, GestureRecognizerFactory>{
      InnerDragGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<InnerDragGestureRecognizer>(
        () => InnerDragGestureRecognizer(),
        (InnerDragGestureRecognizer instance) {
          instance..onDown = onHorizontalDragDown;
        },
      ),
    };

    return RawGestureDetector(
      gestures: _gestureRecognizers,
      child: Container(
        height: 100,
        child: Text("SDfafadsfadsfasdf"),
      ),
    );
  }

  void onHorizontalDragDown(DragDownDetails details) {}
}

class InnerDragGestureRecognizer extends DragGestureRecognizer {
  @override
  String get debugDescription => "test";

  @override
  void addPointer(PointerEvent event) {
    print("handleEvent   addPointer    " + event.toString());
    super.addPointer(event);
  }

  Size offset = new Size(0, 0);

  @override
  void handleEvent(PointerEvent event) {
    print("handleEvent   " + event.toString());
    if (event is PointerDownEvent) {
      offset = new Size(0, 0);
    } else if (event is PointerMoveEvent) {
      offset += event.delta;
      print("handleEvent  PointerMoveEvent " +
          event.toString() +
          "      " +
          offset.height.toString());
      if (offset.height > 18.0) {
        resolve(GestureDisposition.accepted);
      }
    }

    super.handleEvent(event);
  }
}

class InnerScrollController extends ScrollController {}

class InnerWidgetsFlutterBinding extends BindingBase
    with
        GestureBinding,
        ServicesBinding,
        SchedulerBinding,
        PaintingBinding,
        SemanticsBinding,
        RendererBinding,
        WidgetsBinding {
  static WidgetsBinding ensureInitialized() {
    if (WidgetsBinding.instance == null) InnerWidgetsFlutterBinding();
    return WidgetsBinding.instance;
  }

  @override
  ViewConfiguration createViewConfiguration() {
    final double designWidth = 350;
    final double devicePixelRatio = ui.window.physicalSize.width / designWidth;

//    final double designHeight = 600;
//    final double devicePixelRatio =
//        ui.window.physicalSize.height / designHeight;

    Size defaultSize = ui.window.physicalSize / devicePixelRatio;
    print("createViewConfiguration" +
        ui.window.physicalSize.width.toString() +
        "    " +
        ui.window.devicePixelRatio.toString() +
        "   " +
        defaultSize.toString());

    return ViewConfiguration(
      size: defaultSize,
      devicePixelRatio: devicePixelRatio,
    );
  }

  @override // from HitTestTarget
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    print("handleEventhandleEvent   " + event.toString());
    super.handleEvent(event, entry);
  }
}
