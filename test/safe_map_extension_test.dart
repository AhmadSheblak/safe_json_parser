import 'package:flutter_test/flutter_test.dart';
import 'package:safe_json_parser/safe_json_parser.dart';

void main() {
  group('SafeMapExtension Tests', () {
    final json = {
      "user": {
        "profile": {"name": "Ahmad", "age": "25", "active": "true"}
      },
      "data": {
        "items": [
          {"id": 10, "name": "Ali"},
          {"id": 20, "name": "Sara"}
        ]
      }
    };

    test('safeString', () {
      expect(json.safeString("user.profile.name"), "Ahmad");
      expect(json.safeStringOrNull("user.profile.name"), "Ahmad");
    });

    test('safeInt', () {
      expect(json.safeInt("user.profile.age"), 25);
      expect(json.safeIntOrNull("user.profile.age"), 25);
    });

    test('safeBool', () {
      expect(json.safeBool("user.profile.active"), true);
      expect(json.safeBoolOrNull("user.profile.active"), true);
    });

    test('safeListWildcard', () {
      final ids = json.safeListWildcard("data.items.*.id", (e) => e as int);
      final names = json.safeListWildcard("data.items.*.name", (e) => e.toString());
      expect(ids, [10, 20]);
      expect(names, ["Ali", "Sara"]);
    });

    test('Generic get<T>', () {
      expect(json.get<String>("user.profile.name"), "Ahmad");
      expect(json.get<int>("user.profile.age"), 25);
      expect(json.get<bool>("user.profile.active"), true);
    });
  });
}
