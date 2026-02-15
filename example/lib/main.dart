import 'package:flutter/material.dart';
import 'package:safe_json_parser/safe_json_parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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

    final name = json.safeString("user.profile.name");
    final age = json.safeInt("user.profile.age");
    final active = json.safeBool("user.profile.active");

    final ids = json.safeListWildcard("data.items.*.id", (e) => e as int);
    final names = json.safeListWildcard("data.items.*.name", (e) => e.toString());

    print("Name: $name, Age: $age, Active: $active");
    print("IDs: $ids, Names: $names");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Safe JSON Parser Example")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Name: $name"),
              Text("Age: $age"),
              Text("Active: $active"),
              Text("IDs: ${ids.join(', ')}"),
              Text("Names: ${names.join(', ')}"),
            ],
          ),
        ),
      ),
    );
  }
}
