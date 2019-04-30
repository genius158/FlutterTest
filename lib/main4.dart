import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

/// 全局view 的大小适配

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/view_adapter_config.dart';

export 'dart:ui' show AppLifecycleState, Locale;

//
//void main() => InnerWidgetsFlutterBinding.ensureInitialized()
//  ..attachRootWidget(new MyApp())
//  ..scheduleWarmUpFrame();

///
/// ### 关键词Navigator、Route、Overlay
/// 默认情况下，一次路由，由Navigator（route管理类）发起，Overlay（Navigator的子节点，用来挂载route的界面）切换Route（别名、界面管理类）所携带的界面。
///
/// ### 详情
/// Navigator一个StatefulWidget嵌套在MaterialApp内部，其状态类NavigatorState（class NavigatorState extends State<Navigator> with TickerProviderStateMixin）可以在路由界面内,通过Navigator.of(context)获取。
/// <br/>
/// <br/>
/// 一个标准的路由实现
/// ```
///     Navigator.push(context, new MaterialPageRoute(builder: (_) {
///             return MyHomePage();
///           }));
///
/// ```
/// push 内部
/// ```
/// Future<T> push<T extends Object>(Route<T> route) {
///     route.install(_currentOverlayEntry);
///     // 路由表
///     _history.add(route);
///     // 路由动作开始，（设置焦点，开始动画）
///     route.didPush();
///     return route.popped;
///   }
/// ```
///
///  #### route.install(_currentOverlayEntry)作用
///
///  1.先初始化动画相关
///  <br/>
///  2.
///  会初始化两个界面，一个是 _modalBarrier黑色蒙层，和我们需要路由的界面 由 _buildModalScope方法返回
/// ```
/// Iterable<OverlayEntry> createOverlayEntries() sync* {
///     yield _modalBarrier = OverlayEntry(builder: _buildModalBarrier);
///     yield OverlayEntry(builder: _buildModalScope, maintainState: maintainState);
///   }
/// ```
/// _buildModalScope 返回的界面
/// ```
/// _ModalScopeStatus(
///     ...
///         child: AnimatedBuilder(
///         builder: (BuildContext context, Widget child) {
///         // 界面切换动画
///           return widget.route.buildTransitions(
///             context,
///             widget.route.animation,
///             widget.route.secondaryAnimation,
///            );
///         },
///         child: _page ??= RepaintBoundary(
///           child: Builder(
///             builder: (BuildContext context) {
///             // 我们需要路由的界面
///               return widget.route.buildPage(
///                 context,
///                 widget.route.animation,
///                 widget.route.secondaryAnimation,
///               );
///             },
///           ),
///         ),
///     )
/// ```
/// 3.调用navigator.overlay.insertAll()插入第二部初始化的界面
/// ```
/// void insertAll(Iterable<OverlayEntry> entries, { OverlayEntry above }) {
///     if (entries.isEmpty)
///       return;
///     for (OverlayEntry entry in entries) {
///       assert(entry._overlay == null);
///       entry._overlay = this;
///     }
///     // 更新界面
///     setState(() {
///       final int index = above == null ? _entries.length : _entries.indexOf(above) + 1;
///       _entries.insertAll(index, entries);
///     });
///   }
/// ```
/// Overlay 嵌套Stack，通过栈来管理界面
///
/// ```
/// Widget build(BuildContext context) {
/// ...
///     return _Theatre(
///       onstage: Stack(
///         fit: StackFit.expand,
///         children: onstageChildren.reversed.toList(growable: false),
///       ),
///       offstage: offstageChildren,
///     );
///   }
/// ```

void main() => runApp(new MyApp());

waitShow() async {
  await Future.delayed(Duration(milliseconds: 5000)).then((_) {
    runApp(new MyApp());
  });
}

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
        physics: new NoShark(),
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

class NoShark extends ClampingScrollPhysics {
  @override
  ClampingScrollPhysics applyTo(ScrollPhysics ancestor) {
    return new NoShark();
  }

  @override
  double get dragStartDistanceMotionThreshold => 1;
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
//          Navigator.push(context, new MaterialPageRoute(builder: (_) {
//            return MyHomePage(
//              title: "test",
//            );
//          }));

          Navigator.push(
              context,
              new PageRouteBuilder(pageBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return new MyHomePage(title: 'Flutter Demo Home Sub');
              }, transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return SlideTransition(
                  position: Tween<Offset>(
                          begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                      .animate(CurvedAnimation(
                          parent: animation, curve: Curves.fastOutSlowIn)),
                  child: child,
                );
              }));
//          Overlay.of(context).insert(new OverlayEntry(builder: (BuildContext context){
//            return Text("sdfadf");
//          }));
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
