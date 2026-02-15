import '_path_resolver.dart';

extension SafeMapExtension on Map<String, dynamic> {
  // ================= STRING =================
  String safeString(String path, {String defaultValue = ''}) {
    final value = resolvePath(this, path);
    return value?.toString() ?? defaultValue;
  }

  String? safeStringOrNull(String path) => resolvePath(this, path)?.toString();

  // ================= INT =================
  int safeInt(String path, {int defaultValue = 0}) {
    final value = resolvePath(this, path);
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  int? safeIntOrNull(String path) {
    final value = resolvePath(this, path);
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  // ================= DOUBLE =================
  double safeDouble(String path, {double defaultValue = 0.0}) {
    final value = resolvePath(this, path);
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  double? safeDoubleOrNull(String path) {
    final value = resolvePath(this, path);
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  // ================= BOOL =================
  bool safeBool(String path, {bool defaultValue = false}) {
    final value = resolvePath(this, path);
    if (value is bool) return value;
    if (value is String) {
      final lower = value.toLowerCase();
      if (lower == 'true') return true;
      if (lower == 'false') return false;
    }
    if (value is int) return value == 1;
    return defaultValue;
  }

  bool? safeBoolOrNull(String path) {
    final value = resolvePath(this, path);
    if (value is bool) return value;
    if (value is String) {
      final lower = value.toLowerCase();
      if (lower == 'true') return true;
      if (lower == 'false') return false;
    }
    if (value is int) {
      if (value == 1) return true;
      if (value == 0) return false;
    }
    return null;
  }

  // ================= DATE =================
  DateTime? safeDate(String path) {
    final value = resolvePath(this, path);
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  // ================= LIST =================
  List<T> safeList<T>(String path, T Function(Map<String, dynamic>) fromJson) {
    final value = resolvePath(this, path);
    if (value is List) return value.whereType<Map<String, dynamic>>().map(fromJson).toList();
    return [];
  }

  // ================= LIST Wildcard =================
  List<T> safeListWildcard<T>(String path, T Function(dynamic item) transform) {
    final value = resolvePath(this, path);
    if (value is List) return value.expand((e) => e is List ? e : [e]).map(transform).toList();
    return [];
  }

  // ================= MAP =================
  Map<String, dynamic> safeMap(String path) {
    final value = resolvePath(this, path);
    if (value is Map<String, dynamic>) return value;
    return {};
  }

  // ================= Generic get<T>() =================
  T? get<T>(String path, {T? defaultValue}) {
    final value = resolvePath(this, path);
    if (value is T) return value;

    if (value != null) {
      try {
        if (T == int) {
          if (value is int) return value as T;
          if (value is String) return int.tryParse(value) as T? ?? defaultValue;
        }
        if (T == double) {
          if (value is double) return value as T;
          if (value is int) return value.toDouble() as T;
          if (value is String) return double.tryParse(value) as T? ?? defaultValue;
        }
        if (T == bool) {
          if (value is bool) return value as T;
          if (value is String) {
            final lower = value.toLowerCase();
            if (lower == 'true') return true as T;
            if (lower == 'false') return false as T;
          }
          if (value is int) return (value == 1) as T;
        }
        if (T == String) return value.toString() as T;
      } catch (_) {}
    }

    return defaultValue;
  }
}
