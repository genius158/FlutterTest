# flutter_app

A new Flutter application.

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).
# FlutterTest

```

RendererBinding

initInstances(){
  initRenderView()->scheduleInitialFrame()
  -> scheduleInitialLayout(){
    // 渲染标记
    owner._nodesNeedingLayout.add(this)
  };
  
  // handlePersistentFrameCallback 就是 drawFrame()
  // 由引擎回调，开始渲染流程
  // drawFrame(){
  //   pipelineOwner.flushLayout()
  //   {
  //      while (_nodesNeedingLayout.isNotEmpty) {
  //          final List<RenderObject> dirtyNodes = _nodesNeedingLayout;// 渲染标记
  //          _nodesNeedingLayout = <RenderObject>[];
  //          for (RenderObject node in dirtyNodes..sort((RenderObject a, RenderObject b) => a.depth - b.depth)) {
  //            if (node._needsLayout && node.owner == this)
  //              node._layoutWithoutResize();
  //          }
  //        }
  //   };
  //   pipelineOwner.flushCompositingBits();
  //   pipelineOwner.flushPaint()
  //   {
  //      final List<RenderObject> dirtyNodes = _nodesNeedingPaint;
  //      _nodesNeedingPaint = <RenderObject>[];
  //      for (RenderObject node in dirtyNodes..sort((RenderObject a, RenderObject b) => b.depth - a.depth)) {
  //        assert(node._layer != null);
  //        if (node._needsPaint && node.owner == this) {
  //          if (node._layer.attached) {
  //            PaintingContext.repaintCompositedChild(node)
  //            {
  //                childContext ??= PaintingContext(child._layer, child.paintBounds);
  //                
  //                // 由父向子绘制
  //                child._paintWithContext(childContext, Offset.zero);
  //                childContext.stopRecordingIfNeeded();
  //            };
  //          } else {
  //            node._skippedPaintingOnLayer();
  //          }
  //        }
  //      }
  //   };
  //   renderView.compositeFrame()->ui.window.render(scene) native 'Window_render' ; // this sends the bits to the GPU
  //   pipelineOwner.flushSemantics(); // this also sends the semantics to the OS.
  // }
  addPersistentFrameCallback(_handlePersistentFrameCallback);
}

WidgetsBinding
attachRootWidget() -> RenderObjectToWidgetAdapter.attachToRenderTree()-> 
element.mount(null, null) ->_rebuild() -> updateChild() ->inflateWidget()->
_activateWithParent()->attachRenderObject()
->insertChildRenderObject(){
    // 实现例如，完成renderObject的child 的赋值
    renderObject.child = child;
} -> mount()。。。
 (父节点向子节点遍历，完成renderObject树的建立)


```



