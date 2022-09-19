import 'package:imkit/gen/assets.gen.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/utils/utils.dart';

class StrickerUtils {
  static final Map<String, String> _systemStrickers = {};
  static final Map<String, String> _customStrickers = {};
  static late final _state = IMKit.instance.internal.state;
  static const _assetRootPath = 'assets/stickers';

  static Map<String, String> get systemStrickers {
    if (_systemStrickers.isEmpty) {
      for (int i = 1; i <= 40; i++) {
        _systemStrickers["FunFunFamily-$i"] = AssetGenImage('$_assetRootPath/FunFunFamily-$i.png').path;
      }
    }
    return _systemStrickers;
  }

  static Map<String, String> get customStrickers {
    if (_customStrickers.isEmpty) {
      for (var element in _state.stickers) {
        if (Utils.isUrl(element)) {
          _customStrickers[element] = element;
        } else {
          _customStrickers[_filename(element)] = AssetGenImage(element).path;
        }
      }
    }
    return _customStrickers;
  }

  static Map<String, String> get allStrickers {
    if (customStrickers.isNotEmpty) {
      return customStrickers;
    }
    return systemStrickers;
  }

  static String? getStricker(String? strickerId) {
    final value = strickerId ?? "";
    if (value.isNotEmpty && !Utils.isUrl(value)) {
      if (systemStrickers.containsKey(value)) {
        return systemStrickers[value];
      } else if (customStrickers.containsKey(value)) {
        return customStrickers[value];
      }
    }
    return strickerId;
  }

  static String _filename(String? value) => (value ?? "").split('/').last.split('.').first;
}
