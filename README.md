# Safe JSON Parser

[![pub package](https://img.shields.io/pub/v/safe_json_parser)](https://pub.dev/packages/safe_json_parser)
[![likes](https://badges.bar/safe_json_parser/likes)](https://pub.dev/packages/safe_json_parser/score)
[![popularity](https://badges.bar/safe_json_parser/popularity)](https://pub.dev/packages/safe_json_parser/score)
[![maintenance](https://badges.bar/safe_json_parser/maintenance)](https://pub.dev/packages/safe_json_parser/score)

A **defensive and null-safe JSON parser** for Flutter projects.  
Supports nested paths, lists, wildcards, nullable values, and generic type retrieval.

---

## Features

- Safe parsing for `String`, `int`, `double`, `bool`, `DateTime`
- Nullable and default values
- Nested path support (`user.profile.name`)
- List parsing with wildcard (`items.*.id`)
- Generic `get<T>()` for easy type conversion
- Safe map and list handling
- Ready for production

---

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  safe_json_parser: ^0.0.1


---

## Usage

import 'package:safe_json_parser/safe_json_parser.dart';

void main() {
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

  // ---------------- Basic safe parsing ----------------
  final name = json.safeString("user.profile.name");      // "Ahmad"
  final age = json.safeInt("user.profile.age");           // 25
  final active = json.safeBool("user.profile.active");    // true

  print(name);   // Ahmad
  print(age);    // 25
  print(active); // true

  // ---------------- Generic get<T>() ----------------
  final name2 = json.get<String>("user.profile.name");
  final age2 = json.get<int>("user.profile.age");
  final active2 = json.get<bool>("user.profile.active");

  print(name2);   // Ahmad
  print(age2);    // 25
  print(active2); // true

  // ---------------- List parsing with wildcard ----------------
  final ids = json.safeListWildcard("data.items.*.id", (e) => e as int);
  final names = json.safeListWildcard("data.items.*.name", (e) => e.toString());

  print(ids);   // [10, 20]
  print(names); // [Ali, Sara]

  // ---------------- Safe map access ----------------
  final profile = json.safeMap("user.profile");
  final level = profile.safeInt("level"); // returns 0 safely if missing

  print(profile); // {name: Ahmad, age: 25, active: true}
  print(level);   // 0
}

