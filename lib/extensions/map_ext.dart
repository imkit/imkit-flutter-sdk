extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> get removeNullParams {
    final tmp = Map<K, V>.from(this);
    tmp.removeWhere((key, value) => key == null || value == null);

    return tmp;
  }
}
