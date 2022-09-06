import 'dart:math';

class Utils {
  static String uuid() {
    Random random = Random(DateTime.now().millisecond);

    const hexDigits = "0123456789abcdef";
    List<String> uuid = [];

    for (int i = 0; i < 36; i++) {
      final int hexPos = random.nextInt(16);
      uuid.add((hexDigits.substring(hexPos, hexPos + 1)));
    }

    int pos = (int.parse(uuid[19], radix: 16) & 0x3) | 0x8; // bits 6-7 of the clock_seq_hi_and_reserved to 01

    uuid[14] = "4"; // bits 12-15 of the time_hi_and_version field to 0010
    uuid[19] = hexDigits.substring(pos, pos + 1);

    uuid[8] = uuid[13] = uuid[18] = uuid[23] = "-";

    final StringBuffer buffer = StringBuffer();
    buffer.writeAll(uuid);
    return buffer.toString();
  }

  static String formatDuration(int duration) {
    final String minutes = _formatNumber(duration ~/ 60);
    final String seconds = _formatNumber(duration % 60);

    return '$minutes:$seconds';
  }

  static String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }
    return numberStr;
  }
}
