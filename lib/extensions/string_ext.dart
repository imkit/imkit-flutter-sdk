extension StringExtension on String {
  bool get isUrl => Uri.tryParse(this)?.hasAbsolutePath ?? false;

  String get firstWord {
    if (isNotEmpty) {
      return substring(0, 1);
    }
    return "";
  }

  String get breakWord {
    if (isEmpty) {
      return "";
    }
    String breakWord = '';
    for (var element in runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }
}
