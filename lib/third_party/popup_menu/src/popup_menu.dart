import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:imkit/third_party/popup_menu/src/grid_menu_layout.dart';
import 'package:imkit/third_party/popup_menu/src/list_menu_layout.dart';
import 'package:imkit/third_party/popup_menu/src/menu_layout.dart';
import 'package:imkit/third_party/popup_menu/src/triangle_painter.dart';
import 'package:imkit/third_party/popup_menu/src/utils.dart';
import 'popup_menu.dart';

export 'menu_item.dart';
export 'menu_config.dart';

enum MenuType {
  /// 格子
  grid,

  /// 单列
  list
}

enum DirectionType {
  ltr, // left ro right
  rtl, // right to left
}

typedef MenuClickCallback = void Function(MenuItemProvider item);

class PopupMenu {
  OverlayEntry? _entry;
  late List<MenuItemProvider> items;

  /// callback
  final VoidCallback? onDismiss;
  final MenuClickCallback? onClickMenu;
  final VoidCallback? onShow;

  /// Cannot be null
  BuildContext context;

  /// It's showing or not.
  bool _isShow = false;
  bool get isShow => _isShow;

  final MenuConfig config;
  final Size _screenSize = window.physicalSize / window.devicePixelRatio;

  PopupMenu({
    required this.context,
    required this.items,
    this.config = const MenuConfig(),
    this.onClickMenu,
    this.onDismiss,
    this.onShow,
  });

  MenuLayout? menuLayout;

  void show({
    Rect? rect,
    GlobalKey? widgetKey,
  }) {
    assert(rect != null || widgetKey != null, "'rect' and 'key' can't be both null");

    final attachRect = rect ?? getWidgetGlobalRect(widgetKey!);

    if (config.type == MenuType.grid) {
      menuLayout = GridMenuLayout(
        config: config,
        items: items,
        onDismiss: dismiss,
        context: context,
        onClickMenu: onClickMenu,
      );
    } else if (config.type == MenuType.list) {
      menuLayout = ListMenuLayout(
        config: config,
        items: items,
        onDismiss: dismiss,
        context: context,
        onClickMenu: onClickMenu,
      );
    }

    _LayoutP layoutp = _calculateOffset(
      context,
      attachRect,
      0,
      0,
    );

    _entry = OverlayEntry(builder: (context) {
      return build(layoutp, menuLayout!);
    });

    Overlay.of(context)!.insert(_entry!);
    _isShow = true;
    onShow?.call();
  }

  Widget build(_LayoutP layoutp, MenuLayout menuLayout) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => dismiss(),
      onVerticalDragStart: (DragStartDetails details) => dismiss(),
      onHorizontalDragStart: (DragStartDetails details) => dismiss(),
      child: Stack(
        children: <Widget>[
          // triangle arrow
          Positioned(
            // left: layoutp.attachRect.center.dx - 15 / 2,
            left: config.direction == DirectionType.ltr ? layoutp.attachRect.left + config.arrowWidth : null,
            right: config.direction == DirectionType.rtl ? _screenSize.width - layoutp.attachRect.right + config.arrowWidth : null,
            top: layoutp.isDown ? layoutp.offset.dy + layoutp.height : layoutp.offset.dy - config.arrowHeight,
            child: CustomPaint(
              size: Size(config.arrowWidth, config.arrowHeight),
              painter: TrianglePainter(isDown: layoutp.isDown, color: config.backgroundColor),
            ),
          ),
          // menu content
          Positioned(
            left: config.direction == DirectionType.ltr ? layoutp.attachRect.left : null,
            right: config.direction == DirectionType.rtl ? _screenSize.width - layoutp.attachRect.right : null,
            bottom: layoutp.isDown ? _screenSize.height - layoutp.offset.dy - layoutp.height : null,
            top: layoutp.isDown ? null : layoutp.offset.dy,
            child: menuLayout.build(),
          ),
        ],
      ),
    );
  }

  /// 计算布局位置
  _LayoutP _calculateOffset(
    BuildContext context,
    Rect attachRect,
    double contentWidth,
    double contentHeight,
  ) {
    double dx = attachRect.left + attachRect.width / 2.0 - contentWidth / 2.0;
    if (dx < 10.0) {
      dx = 10.0;
    }

    if (dx + contentWidth > _screenSize.width && dx > 10.0) {
      double tempDx = _screenSize.width - contentWidth - 10;
      if (tempDx > 10) {
        dx = tempDx;
      }
    }

    double dy = attachRect.top - contentHeight;
    bool isDown = false;
    if (dy <= MediaQuery.of(context).padding.top + 150) {
      // The have not enough space above, show menu under the widget.
      dy = config.arrowHeight + attachRect.height + attachRect.top;
      isDown = false;
    } else {
      dy -= config.arrowHeight;
      isDown = true;
    }

    return _LayoutP(
      width: contentWidth,
      height: contentHeight,
      attachRect: attachRect,
      offset: Offset(dx, dy),
      isDown: isDown,
    );
  }

  void dismiss() {
    if (!_isShow) {
      // Remove method should only be called once
      return;
    }

    _entry?.remove();
    _isShow = false;
    onDismiss?.call();
  }
}

class _LayoutP {
  double width;
  double height;
  Offset offset;
  Rect attachRect;
  bool isDown;

  _LayoutP({
    required this.width,
    required this.height,
    required this.offset,
    required this.attachRect,
    required this.isDown,
  });
}
