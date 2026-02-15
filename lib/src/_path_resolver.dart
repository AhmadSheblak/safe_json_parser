dynamic resolvePath(dynamic current, String path) {
  final keys = path.split('.');
  return _resolve(current, keys);
}

dynamic _resolve(dynamic current, List<String> keys) {
  if (current == null) return null;
  if (keys.isEmpty) return current;

  final key = keys.first;
  final rest = keys.sublist(1);

  if (key == '*') {
    if (current is List) {
      return current.map((e) => _resolve(e, rest)).toList();
    } else {
      return null;
    }
  }

  if (current is List) {
    final index = int.tryParse(key);
    if (index == null || index < 0 || index >= current.length) return null;
    return _resolve(current[index], rest);
  }

  if (current is Map<String, dynamic>) {
    return _resolve(current[key], rest);
  }

  return null;
}
