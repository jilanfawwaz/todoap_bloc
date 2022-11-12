import 'dart:math';

class IDGenerator {
  static String generate() {
    Random rand = Random(DateTime.now().millisecond);

    const String hexDigits = "0123456789abcdef";

    //? membuat list sepanjang 36, dengan isi '', dan bersifat growable atau dapat ditambah lagi isinya
    final List<String> uuid = List.filled(36, '', growable: true);

    for (int i = 0; i < 36; i++) {
      final int hexPos = rand.nextInt(16);
      //? substring itu adalah angka start dan end yang mau diambil
      uuid[i] = (hexDigits.substring(hexPos, hexPos + 1));
    }

    //? konversi string menjadi int, dengan radix yaitu bentuk angka itu (2 berarti biner, 16 berarti heksadesimal), keyword '&' dan '|' adalah untuk operasi bitwise (dalam bentuk biner dari seluruh angka)
    int pos = (int.parse(uuid[19], radix: 16) & 0x3 | 0x8);
    uuid[14] = '4';
    uuid[19] = hexDigits.substring(pos, pos + 1);

    uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';

    final StringBuffer buffer = StringBuffer();
    buffer.writeAll(uuid);
    return buffer.toString();
  }
}
