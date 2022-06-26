import 'package:flutter/material.dart';

// 路由操作枚举
enum CWRouteChangeType { push, pop }

// 路由监听widget
class IMRouteListenWidget extends StatefulWidget {
  static RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  final Widget child;

  // 当前页面展示时的回调
  final Function(CWRouteChangeType)? onAppear;

  // 当前页面消失时的回调
  final Function(CWRouteChangeType)? onDisappear;

  // 构造方法
  const IMRouteListenWidget({Key? key, required this.child, this.onAppear, this.onDisappear}) : super(key: key);

  @override
  _IMRouteListenWidgetState createState() => _IMRouteListenWidgetState();
}

class _IMRouteListenWidgetState extends State<IMRouteListenWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    ModalRoute? route = ModalRoute.of(context);
    if (route != null) {
      IMRouteListenWidget.routeObserver.unsubscribe(this);
      // 注册监听
      IMRouteListenWidget.routeObserver.subscribe(this, route as PageRoute);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // 移除监听
    IMRouteListenWidget.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    if (widget.onAppear != null) {
      widget.onAppear!(CWRouteChangeType.push);
    }
    super.didPush();
  }

  @override
  void didPop() {
    if (widget.onDisappear != null) {
      widget.onDisappear!(CWRouteChangeType.pop);
    }
    super.didPop();
  }

  @override
  void didPushNext() {
    if (widget.onDisappear != null) {
      widget.onDisappear!(CWRouteChangeType.push);
    }
    super.didPushNext();
  }

  @override
  void didPopNext() {
    if (widget.onAppear != null) {
      widget.onAppear!(CWRouteChangeType.pop);
    }
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
