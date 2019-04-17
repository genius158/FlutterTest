/// 全局view 的大小适配

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:ui' as ui show window;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'dart:collection';
import 'dart:ui' as ui show window, PointerDataPacket;

import 'package:flutter_app/view_adapter_config.dart';

export 'dart:ui' show AppLifecycleState, Locale;

void main() => InnerWidgetsFlutterBinding.ensureInitialized()
  ..attachRootWidget(new MyApp())
  ..scheduleWarmUpFrame();

//waitShow() async {
//  await Future.delayed(Duration(milliseconds: 5000)).then((_) {
//    InnerWidgetsFlutterBinding.ensureInitialized()
//      ..attachRootWidget(new MyApp())
//      ..scheduleWarmUpFrame();
//  });
//}

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
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (_) {
            return MyHomePage(
              title: "test",
            );
          }));
        },
        child: InnerContainer(
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(0),
                width: 250,
                height: 40,
                color: Colors.amber,
                child: Text("width 250dp"),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(0),
                width: SCREEN_WIDTH - 250,
                height: 40,
                color: Colors.lightBlue,
                child: Text("${SCREEN_WIDTH - 250}dp"),
              ),
            ],
          ),
        ));
  }
}

class InnerContainer extends SingleChildRenderObjectWidget {
  InnerContainer(_widget) : super(child: _widget);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderInner();
  }
}

class RenderInner extends RenderPadding {
  RenderInner() : super(padding: EdgeInsets.all(0));

  @override
  // TODO: implement size
  Size get size => printSize();

  printSize() {
    print("printSize    " + super.size.toString());
    return super.size;
  }
}

class InnerWidgetsFlutterBinding extends WidgetsFlutterBinding {
  static WidgetsBinding ensureInitialized() {
    if (WidgetsBinding.instance == null) InnerWidgetsFlutterBinding();
    return WidgetsBinding.instance;
  }

  @override
  ViewConfiguration createViewConfiguration() {
    return ViewConfiguration(
      size: getScreenAdapterSize(),
      devicePixelRatio: getAdapterRatio(),
    );
  }

  ///
  /// 以下一大重写与 GestureBinding
  /// 唯一目的 把 _handlePointerDataPacket 方法 事件原始数据转换 改用
  /// 修改过的 PixelRatio

  @override
  void initInstances() {
    super.initInstances();
    ui.window.onPointerDataPacket = _handlePointerDataPacket;
  }

  @override
  void unlocked() {
    super.unlocked();
    _flushPointerEventQueue();
  }

  final Queue<PointerEvent> _pendingPointerEvents = Queue<PointerEvent>();

  void _handlePointerDataPacket(ui.PointerDataPacket packet) {
    _pendingPointerEvents.addAll(PointerEventConverter.expand(
        packet.data,
        // 适配事件的转换比率,采用我们修改的
        getAdapterRatio()));
    if (!locked) _flushPointerEventQueue();
  }

  @override
  void cancelPointer(int pointer) {
    if (_pendingPointerEvents.isEmpty && !locked)
      scheduleMicrotask(_flushPointerEventQueue);
    _pendingPointerEvents.addFirst(PointerCancelEvent(pointer: pointer));
  }

  void _flushPointerEventQueue() {
    assert(!locked);
    while (_pendingPointerEvents.isNotEmpty)
      _handlePointerEvent(_pendingPointerEvents.removeFirst());
  }

  final Map<int, HitTestResult> _hitTests = <int, HitTestResult>{};

  void _handlePointerEvent(PointerEvent event) {
    assert(!locked);
    HitTestResult result;
    if (event is PointerDownEvent) {
      assert(!_hitTests.containsKey(event.pointer));
      result = HitTestResult();
      hitTest(result, event.position);
      _hitTests[event.pointer] = result;
      assert(() {
        if (debugPrintHitTestResults) debugPrint('$event: $result');
        return true;
      }());
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      result = _hitTests.remove(event.pointer);
    } else if (event.down) {
      result = _hitTests[event.pointer];
    } else {
      return; // We currently ignore add, remove, and hover move events.
    }
    if (result != null) dispatchEvent(event, result);
  }
}
