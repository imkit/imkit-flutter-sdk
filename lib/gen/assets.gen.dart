/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsStickersGen {
  const $AssetsStickersGen();

  /// File path: assets/stickers/sticker_1.png
  AssetGenImage get sticker1 =>
      const AssetGenImage('assets/stickers/sticker_1.png');

  /// File path: assets/stickers/sticker_10.png
  AssetGenImage get sticker10 =>
      const AssetGenImage('assets/stickers/sticker_10.png');

  /// File path: assets/stickers/sticker_2.png
  AssetGenImage get sticker2 =>
      const AssetGenImage('assets/stickers/sticker_2.png');

  /// File path: assets/stickers/sticker_3.png
  AssetGenImage get sticker3 =>
      const AssetGenImage('assets/stickers/sticker_3.png');

  /// File path: assets/stickers/sticker_4.png
  AssetGenImage get sticker4 =>
      const AssetGenImage('assets/stickers/sticker_4.png');

  /// File path: assets/stickers/sticker_5.png
  AssetGenImage get sticker5 =>
      const AssetGenImage('assets/stickers/sticker_5.png');

  /// File path: assets/stickers/sticker_6.png
  AssetGenImage get sticker6 =>
      const AssetGenImage('assets/stickers/sticker_6.png');

  /// File path: assets/stickers/sticker_7.png
  AssetGenImage get sticker7 =>
      const AssetGenImage('assets/stickers/sticker_7.png');

  /// File path: assets/stickers/sticker_8.png
  AssetGenImage get sticker8 =>
      const AssetGenImage('assets/stickers/sticker_8.png');

  /// File path: assets/stickers/sticker_9.png
  AssetGenImage get sticker9 =>
      const AssetGenImage('assets/stickers/sticker_9.png');
}

class Assets {
  Assets._();

  static const $AssetsStickersGen stickers = $AssetsStickersGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
