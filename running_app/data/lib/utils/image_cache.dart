import 'dart:typed_data';

class ImageCache {
  final _map = <int, Uint8List>{};

  // Add an entry to the map
  void add(int key, Uint8List value) {
    _map[key] = value;
  }

  // Get the Uint8List for a given int key
  Uint8List? get(int key) {
    return _map[key];
  }

  // Remove an entry from the map
  void remove(int key) {
    _map.remove(key);
  }

  // Clear all entries from the map
  void clear() {
    _map.clear();
  }

  // Get a list of all keys in the map
  List<int> get keys => _map.keys.toList();
}
