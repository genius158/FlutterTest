# flutter 屏幕适配 demo [main](https://github.com/genius158/FlutterTest/blob/master/lib/main.dart)
一种一劳永逸的全局适配方式

## 效果
320x480
<br/>
<img src="https://github.com/genius158/FlutterTest/blob/master/bitmap/screenadapter1.png" width="320" height="480" alt="320x480" align=center>
<br/>
1080x1920
<br/>
<img src="https://github.com/genius158/FlutterTest/blob/master/bitmap/screenadapter2.png" width="320" height="568" alt="1080x1920" align=center>

# 原理 （具体代码 [main](https://github.com/genius158/FlutterTest/blob/master/lib/main.dart)）
1.更改配置的 ViewConfiguration 的size和devicePixelRatio (ViewConfiguration 这个类再 RenderView 里赋值,而RenderView是
renderObject树的根，在布局和绘制的过程中，会根据ViewConfiguration的值来做由父向子的布局绘制操作)
<br/>
2.PointerDataPacket 从引擎冲过来的事件，默认采用的是 系统的devicePixelRatio ,这里就需要适用我们的值
复写 initInstances() 内部 ui.window.onPointerDataPacket=_handlePointerDataPacket 赋值以下
```
void _handlePointerDataPacket(ui.PointerDataPacket packet) {
    _pendingPointerEvents.addAll(PointerEventConverter.expand(
        packet.data,
        // 适配事件的转换比率,采用我们修改的
        getAdapterRatio()));
    if (!locked) _flushPointerEventQueue();
  }
```
 
